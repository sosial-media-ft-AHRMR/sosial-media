import 'package:flutter/material.dart';
import 'package:sosial_media/screens/chat_room_screen.dart';

/// Model data untuk item percakapan di Chat List
class ChatItemData {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final bool isAktif;
  final String avatarAsset;

  const ChatItemData({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.isAktif,
    required this.avatarAsset,
  });
}

class ChatListScreen extends StatefulWidget {
  final bool showBottomNav;

  const ChatListScreen({
    super.key,
    this.showBottomNav = true,
  });

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _currentBottomNavIndex = 3; // Index 3 adalah Pesan/Chat

  // Daftar percakapan asli sesuai desain Figma "Komunikasi dan Pesan"
  // Menggunakan file foto asli HD milik tim di assets/images/
  final List<ChatItemData> _allChats = const [
    ChatItemData(
      id: 'shawn',
      name: 'shawn',
      lastMessage: 'Where?',
      time: '01.00',
      isAktif: true,
      avatarAsset: 'assets/images/Shawn PP.jpg',
    ),
    ChatItemData(
      id: 'thv',
      name: 'thv',
      lastMessage: 'How are you?',
      time: '02.00',
      isAktif: false,
      avatarAsset: 'assets/images/thv PP.jpg',
    ),
    ChatItemData(
      id: 'your_idol',
      name: 'your.idol',
      lastMessage: 'Im YourIdol',
      time: '22.00',
      isAktif: false,
      avatarAsset: 'assets/images/Your.Idol PP.jpg',
    ),
    ChatItemData(
      id: 'mr_shadow',
      name: 'mr.shadow',
      lastMessage: 'Who?',
      time: '19.00',
      isAktif: true,
      avatarAsset: 'assets/images/MrShadow PP.jpg',
    ),
    ChatItemData(
      id: 'peter',
      name: 'peter',
      lastMessage: 'Halo, Qcumber!',
      time: '12.00',
      isAktif: false,
      avatarAsset: 'assets/images/Peter PP.jpg',
    ),
  ];

  List<ChatItemData> _filteredChats = [];

  @override
  void initState() {
    super.initState();
    _filteredChats = _allChats;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredChats = _allChats;
      } else {
        _filteredChats = _allChats.where((chat) {
          return chat.name.toLowerCase().contains(query) ||
              chat.lastMessage.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void _openChatRoom(ChatItemData chat) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ChatRoomScreen(contactName: chat.name, avatarAsset: chat.avatarAsset),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.85, -0.65),
            radius: 1.35,
            colors: [
              Color(0xFFA5C895), // Gradasi hijau pastel lembut khas Figma
              Color(0xFFFFFFFF), // Memudar ke putih bersih
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // 1. App Bar Header: Judul Aplikasi "Qcumber"
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Qcumber',
                      style: TextStyle(
                        fontFamily: 'sans-serif',
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF165540), // Dark green khas Figma
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // 2. Search Bar: Input pencarian dengan background & icon khas Figma
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9F1E4), // Background kehijauan lembut Figma
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF165540),
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF165540),
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Search...',
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
                          if (_searchController.text.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                _searchController.clear();
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(
                                  Icons.close,
                                  size: 20,
                                  color: Color(0xFF7E8E85),
                                ),
                              ),
                            ),
                          const Padding(
                            padding: EdgeInsets.only(right: 14),
                            child: Icon(
                              Icons.search,
                              size: 26,
                              color: Color(0xFF165540),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // 3. Section Title: "Pesan"
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Pesan',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF165540),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 4. Daftar Percakapan (ListView Chat Items)
                  Expanded(
                    child: _filteredChats.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 48,
                                  color: const Color(0xFF165540).withValues(alpha: 0.4),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Pesan tidak ditemukan',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: const Color(0xFF165540).withValues(alpha: 0.6),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            padding: EdgeInsets.only(
                              top: 8,
                              bottom: widget.showBottomNav ? 110 : 90,
                            ),
                            itemCount: _filteredChats.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 4),
                            itemBuilder: (context, index) {
                              final chat = _filteredChats[index];
                              return _buildChatItem(chat);
                            },
                          ),
                  ),
                ],
              ),

              // 5. Floating Bottom Navigation Bar (Hanya tampil jika showBottomNav = true)
              if (widget.showBottomNav)
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 24,
                  child: _buildFloatingBottomNav(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget Item Percakapan
  Widget _buildChatItem(ChatItemData chat) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _openChatRoom(chat),
        splashColor: const Color(0xFF165540).withValues(alpha: 0.08),
        highlightColor: const Color(0xFF165540).withValues(alpha: 0.04),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            children: [
              // Avatar Bulat Bersih & Badge Status Online/Aktif Sesuai Figma
              Stack(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        chat.avatarAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFFD8E4D5),
                            child: const Icon(
                              Icons.person,
                              color: Color(0xFF165540),
                              size: 32,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Indicator Dot (Aktif: Hijau Tua #165540, Nonaktif: Sage Muda #A2B78D)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: chat.isAktif
                            ? const Color(0xFF165540) // Hijau tua aktif Figma
                            : const Color(0xFFA2B78D), // Sage muda nonaktif Figma
                        border: Border.all(
                          color: Colors.white,
                          width: 2.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 16),

              // Info Nama & Pesan Terakhir
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF165540),
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      chat.isAktif
                          ? '${chat.lastMessage}  •  Aktif'
                          : chat.lastMessage,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4A6B5D),
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Waktu Pesan
              Text(
                chat.time,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF165540),
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget Floating Bottom Navigation Bar
  Widget _buildFloatingBottomNav() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.09),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavIconButton(
            index: 0,
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
          ),
          _buildNavIconButton(
            index: 1,
            icon: Icons.search,
            activeIcon: Icons.search,
          ),
          // Center Add Button (+)
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Buat Postingan Baru'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF2B7853),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2B7853).withValues(alpha: 0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
          _buildNavIconButton(
            index: 3,
            icon: Icons.chat_bubble_outline_rounded,
            activeIcon: Icons.chat_bubble_rounded,
          ),
          _buildNavIconButton(
            index: 4,
            icon: Icons.person_outline_rounded,
            activeIcon: Icons.person_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildNavIconButton({
    required int index,
    required IconData icon,
    required IconData activeIcon,
  }) {
    final bool isActive = _currentBottomNavIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentBottomNavIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF2B7853).withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          isActive ? activeIcon : icon,
          size: 26,
          color: isActive
              ? const Color(0xFF2B7853)
              : const Color(0xFF7E8E85),
        ),
      ),
    );
  }
}
