import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sosial_media/screens/chat_list_screen.dart';
import 'fitur pendukung/fitur_pendukung.dart';
import 'pembuatan_feed/feed_page.dart';
import 'pembuatan_feed/menambah_cerita.dart';
import 'profil/my_profile_page.dart';
import 'tampilan_utama/login_page.dart';
import 'tampilan_utama/search_page.dart';
import 'theme/qcumber_colors.dart';
import 'widgets/floating_bottom_nav.dart';
import 'widgets/popups/logout_dialog.dart';

/// MainScaffold yang menaungi 5 tab navigasi utama dan Floating Bottom Navigation Bar
class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FeedPageState> _feedPageKey = GlobalKey<FeedPageState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: QcumberColors.white,
      drawer: _buildAppDrawer(),
      body: Stack(
        children: [
          // 1. Konten Halaman sesuai Tab Aktif
          IndexedStack(
            index: _currentIndex,
            children: [
              // Tab 0: Halaman Feed Beranda (Fixed Header tidak ikut ter-scroll)
              FeedPage(key: _feedPageKey, scaffoldKey: _scaffoldKey),

              // Tab 1: Halaman Pencarian (Aktif Penuh Sesuai Figma Searching.png)
              const SearchPage(),

              // Tab 2: Buat Postingan Baru
              _buildPlaceholderPage(
                title: 'Buat Postingan Baru',
                icon: Icons.add_photo_alternate_rounded,
                description: 'Bagikan momen segar hari ini kepada teman-teman',
                actionButtonText: 'Mulai Buat Postingan',
                onActionPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewSlicePage(),
                    ),
                  );
                },
              ),

              // Tab 3: Pesan & Obrolan (Terintegrasi Penuh dengan Fitur Chat & Telepon)
              const ChatListScreen(),

              // Tab 4: Profil Saya (Sesuai Desain Figma My Profile.png)
              const MyProfilePage(showBackButton: false),
            ],
          ),

          // 2. Floating Bottom Navigation Bar (Mengambang di Atas Konten)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FloatingBottomNav(
              currentIndex: _currentIndex,
              onTabSelected: (index) {
                if (index == 2) {
                  // Tombol Tambah (+) langsung membuka alur New Slice (cerita & postingan) sesuai Figma
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewSlicePage(),
                    ),
                  );
                } else {
                  setState(() {
                    _currentIndex = index;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Drawer navigasi samping sesuai 100% dengan Figma Menu Bar.png (Gambar Kedua)
  Widget _buildAppDrawer() {
    return Drawer(
      width: 224,
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFDBE6D5),
              Color(0xFFF7FAF5),
              Colors.white,
            ],
            stops: [0.0, 0.22, 0.5],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 28),

              // Header Profil Pengguna: Avatar & Nama Alexumber (Sesuai Figma)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _currentIndex = 4);
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/feed/alexumber_avatar.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.account_circle,
                              size: 40,
                              color: QcumberColors.primaryGreen,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Alexumber',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: QcumberColors.primaryGreen,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // 1. Menu: Notifikasi
              _buildDrawerItem(
                iconAsset: 'assets/feed/icon_drawer_notifikasi.png',
                fallbackIcon: Icons.notifications_none_rounded,
                title: 'Notifikasi',
                onTap: () {
                  final navigator = Navigator.of(context);
                  navigator.pop();
                  navigator.push(
                    MaterialPageRoute(
                      builder: (context) => const NotifikasiPage(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 26),

              // 2. Menu: Disimpan
              _buildDrawerItem(
                iconAsset: 'assets/feed/icon_drawer_disimpan.png',
                fallbackIcon: Icons.bookmark_border_rounded,
                title: 'Disimpan',
                onTap: () {
                  final navigator = Navigator.of(context);
                  navigator.pop();
                  navigator.push(
                    MaterialPageRoute(
                      builder: (context) => const DisimpanPage(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 26),

              // 3. Menu: Pengaturan
              _buildDrawerItem(
                iconAsset: 'assets/feed/icon_drawer_pengaturan.png',
                fallbackIcon: Icons.settings_outlined,
                title: 'Pengaturan',
                onTap: () {
                  final navigator = Navigator.of(context);
                  navigator.pop();
                  navigator.push(
                    MaterialPageRoute(
                      builder: (context) => const PengaturanPage(),
                    ),
                  );
                },
              ),

              const Spacer(),

              // 4. Menu: Keluar (Bawah Sesuai Figma)
              _buildDrawerItem(
                iconAsset: 'assets/feed/icon_drawer_keluar.png',
                fallbackIcon: Icons.logout_rounded,
                title: 'Keluar',
                onTap: () {
                  Navigator.pop(context);
                  showLogoutConfirmationDialog(
                    context,
                    onConfirmLogout: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                        (route) => false,
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  /// Item menu pada App Drawer sesuai tata letak Figma Menu Bar.png
  Widget _buildDrawerItem({
    required String iconAsset,
    required IconData fallbackIcon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 6.0),
        child: Row(
          children: [
            Image.asset(
              iconAsset,
              height: 24,
              width: 22,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
              errorBuilder: (context, error, stackTrace) => Icon(
                fallbackIcon,
                size: 24,
                color: QcumberColors.primaryGreen,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: QcumberColors.primaryGreen,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Placeholder untuk tab selain Feed dan Search
  Widget _buildPlaceholderPage({
    required String title,
    required IconData icon,
    required String description,
    String? actionButtonText,
    VoidCallback? onActionPressed,
  }) {
    return Container(
      color: QcumberColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                shape: BoxShape.circle,
                border: Border.all(
                  color: QcumberColors.cucumberGreen.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: Icon(icon, size: 40, color: QcumberColors.primaryGreen),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: QcumberColors.primaryGreen,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: QcumberColors.sageText,
              ),
            ),
            if (actionButtonText != null && onActionPressed != null) ...[
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: onActionPressed,
                icon: const Icon(Icons.add, color: Colors.white),
                label: Text(
                  actionButtonText,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: QcumberColors.primaryGreen,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
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
