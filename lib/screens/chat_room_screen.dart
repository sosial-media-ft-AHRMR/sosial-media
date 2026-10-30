import 'package:flutter/material.dart';
import 'package:sosial_media/screens/incoming_call_audio_screen.dart';
import 'package:sosial_media/screens/incoming_call_video_screen.dart';
import 'package:sosial_media/widgets/phone_frame.dart';

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
  bool _showEmojiPicker = false;

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

  // Koleksi emoji populer yang ada di Figma chat_room_emoji_picker
  final List<String> _emojis = const [
    '😀', '😃', '😄', '😁', '😆', '😅', '😂', '🤣',
    '😊', '😇', '🙂', '🙃', '😉', '😌', '😍', '🥰',
    '😘', '😗', '😙', '😚', '😋', '😛', '😝', '😜',
    '🤪', '🤨', '🧐', '🤓', '😎', '🤩', '🥳', '😏',
    '😒', '😞', '😔', '😟', '😕', '🙁', '☹️', '😣',
    '😖', '😫', '😩', '🥺', '😢', '😭', '😤', '😠',
    '😡', '🤬', '🤯', '😳', '🥵', '🥶', '😱', '😨',
    '👍', '👎', '👏', '🙌', '🙏', '❤️', '🔥', '✨',
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
      _showEmojiPicker = false;
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

  void _onEmojiSelected(String emoji) {
    setState(() {
      _messageController.text += emoji;
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
    return PhoneFrame(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFDCEAD8), // Gradient khas Figma Chat Room
                Color(0xFFEFF5ED),
                Color(0xFFFFFFFF),
              ],
              stops: [0.0, 0.38, 1.0],
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

                // 3. Bottom Input Bar Khas Figma
                _buildInputBar(),

                // 4. Panel Emoji Tray
                if (_showEmojiPicker) _buildEmojiPicker(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// App Bar Atas Chat Room
  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.chevron_left,
              size: 34,
              color: Color(0xFF1B4D3E),
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
                      color: Color(0xFF1B4D3E),
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
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1B4D3E),
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
                        color: Color(0xFF22C55E),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Online',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF1B4D3E),
                        fontWeight: FontWeight.w500,
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
          color: const Color(0xFF1B4D3E),
        ),
      ),
    );
  }

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
          color: msg.isMe ? const Color(0xFFA9DC76) : const Color(0xFFD8D8DF),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(msg.isMe ? 18 : 4),
            bottomRight: Radius.circular(msg.isMe ? 4 : 18),
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
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: msg.isMe ? const Color(0xFF1B4D3E) : const Color(0xFF1E293B),
            height: 1.3,
          ),
        ),
      ),
    );
  }

  Widget _buildInputBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      child: Container(
        height: 54,
        padding: const EdgeInsets.symmetric(horizontal: 14),
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
            color: const Color(0xFF1B4D3E).withValues(alpha: 0.18),
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _showEmojiPicker = !_showEmojiPicker;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  _showEmojiPicker
                      ? Icons.keyboard_outlined
                      : Icons.sentiment_satisfied_alt_outlined,
                  size: 24,
                  color: const Color(0xFF1B4D3E),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _messageController,
                onSubmitted: (_) => _sendMessage(),
                onChanged: (val) {
                  setState(() {});
                },
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF1B4D3E),
                  fontWeight: FontWeight.w500,
                ),
                decoration: const InputDecoration(
                  hintText: 'Ketik Pesan..',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF7E8E85),
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            if (_messageController.text.trim().isNotEmpty)
              GestureDetector(
                onTap: _sendMessage,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF2B7853),
                  ),
                  child: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 20,
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
                    size: 24,
                    color: Color(0xFF1B4D3E),
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
                    size: 24,
                    color: Color(0xFF1B4D3E),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEmojiPicker() {
    return Container(
      height: 240,
      color: const Color(0xFFF1F6F0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Emoji',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1B4D3E),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showEmojiPicker = false;
                  });
                },
                child: const Icon(
                  Icons.close,
                  size: 20,
                  color: Color(0xFF7E8E85),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _emojis.length,
              itemBuilder: (context, index) {
                final emoji = _emojis[index];
                return GestureDetector(
                  onTap: () => _onEmojiSelected(emoji),
                  child: Center(
                    child: Text(
                      emoji,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
