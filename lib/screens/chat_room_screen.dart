import 'package:flutter/material.dart';
import 'package:sosial_media/screens/incoming_call_audio_screen.dart';
import 'package:sosial_media/screens/incoming_call_video_screen.dart';

/// Model pesan dalam ruang percakapan
class ChatMessage {
  final String text;
  final bool isMe;
  final String time;

  const ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
  });
}

class ChatRoomScreen extends StatefulWidget {
  final String contactName;
  final String avatarAsset;

  const ChatRoomScreen({
    super.key,
    this.contactName = 'shawn',
    this.avatarAsset = 'assets/images/Shawn PP.jpg',
  });

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Daftar pesan percakapan asli sesuai desain Figma
  final List<ChatMessage> _messages = [
    const ChatMessage(
      text: 'Hai, Alex!',
      isMe: false,
      time: '01.00',
    ),
    const ChatMessage(
      text: 'Halo, Shawn!',
      isMe: true,
      time: '01.01',
    ),
    const ChatMessage(
      text: 'How are you?',
      isMe: false,
      time: '01.02',
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          isMe: true,
          time: TimeOfDay.now().format(context),
        ),
      );
      _messageController.clear();
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _openAudioCall() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            IncomingCallAudioScreen(
          callerName: widget.contactName,
          callerAvatar: widget.avatarAsset,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  void _openVideoCall() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            IncomingCallVideoScreen(
          callerName: widget.contactName,
          callerAvatar: widget.avatarAsset,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.85, -0.65),
            radius: 1.35,
            colors: [
              Color(0xFFA5C895), // Gradient hijau lembut khas Figma Chat Room
              Color(0xFFFFFFFF), // Memudar ke putih bersih
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // 1. App Bar Chat Room Khas Figma
              _buildAppBar(),

              // 2. Daftar Pesan Percakapan (Message Bubbles)
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    return _buildMessageBubble(msg);
                  },
                ),
              ),

              // 3. Bottom Input Bar Khas Figma (Pill Input + Mic/Gallery/Send)
              _buildInputBar(),
            ],
          ),
        ),
      ),
    );
  }

  /// App Bar Atas Chat Room Khas Figma
  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.chevron_left,
              size: 34,
              color: Color(0xFF165540),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                widget.avatarAsset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFD8E4D5),
                    child: const Icon(
                      Icons.person,
                      color: Color(0xFF165540),
                      size: 28,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.contactName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF165540),
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF165540), // Titik online hijau Figma
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Online',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF165540),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildCircleIconButton(
            icon: Icons.phone,
            onTap: _openAudioCall,
          ),
          const SizedBox(width: 8),
          _buildCircleIconButton(
            icon: Icons.videocam,
            onTap: _openVideoCall,
          ),
          const SizedBox(width: 8),
          _buildCircleIconButton(
            icon: Icons.more_vert,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Menu Percakapan Lainnya'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFE2EBE0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 20,
          color: const Color(0xFF165540),
        ),
      ),
    );
  }

  /// Bubble Pesan Presisi 99% Sesuai Figma
  Widget _buildMessageBubble(ChatMessage msg) {
    return Align(
      alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: msg.isMe
              ? const Color(0xFFB5DA78) // Outgoing: Hijau lemon / sage terang khas Figma
              : const Color(0xFFD5DBD8), // Incoming: Abu-abu netral kehijauan khas Figma
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(msg.isMe ? 18 : 3), // Kiri lancip untuk incoming
            bottomRight: Radius.circular(msg.isMe ? 3 : 18), // Kanan lancip untuk outgoing
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          msg.text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF165540), // Teks hijau tua presisi Figma
            height: 1.3,
          ),
        ),
      ),
    );
  }

  /// Bottom Input Bar Sesuai 99% Figma Chat Room.png & Chat Room-4.png
  Widget _buildInputBar() {
    final bool hasText = _messageController.text.trim().isNotEmpty;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      child: Container(
        height: 54,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: const Color(0xFFC4D5C0), // Border tipis halus Figma
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            // Kolom Teks Input (Langsung 'Ketik Pesan..' di sebelah kiri sesuai Figma)
            Expanded(
              child: TextField(
                controller: _messageController,
                onSubmitted: (_) => _sendMessage(),
                onChanged: (_) {
                  setState(() {});
                },
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF165540),
                  fontWeight: FontWeight.w500,
                ),
                decoration: const InputDecoration(
                  hintText: 'Ketik Pesan..',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF165540),
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),

            // Tombol di Sisi Kanan Input Bar
            if (hasText)
              GestureDetector(
                onTap: _sendMessage,
                behavior: HitTestBehavior.opaque,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Icon(
                    Icons.send_rounded,
                    color: Color(0xFF165540), // Icon kirim pesawat kertas hijau Figma Chat Room-4.png
                    size: 26,
                  ),
                ),
              )
            else ...[
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Perekam Suara Aktif'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(
                    Icons.mic_none_rounded,
                    size: 26,
                    color: Color(0xFF165540),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pilih Foto dari Galeri'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(
                    Icons.image_outlined,
                    size: 26,
                    color: Color(0xFF165540),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
