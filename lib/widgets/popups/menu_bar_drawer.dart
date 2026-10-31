import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../fitur pendukung/disimpan_page.dart';
import '../../fitur pendukung/notifikasi_page.dart';
import '../../fitur pendukung/pengaturan_page.dart';
import '../../theme/qcumber_colors.dart';
import 'logout_dialog.dart';

/// Menu Bar Drawer Qcumber
/// Konversi presisi 99% dari Desain Figma "Menu Bar.png" (220 x 874)
///
/// Fitur:
/// - Lebar presisi 220px dengan gradien halus latar hijau sage lembut ke putih
/// - Profil header: Foto avatar Alexumber dan username 'Alexumber' (#165540)
/// - Menu navigasi: Notifikasi, Disimpan, Pengaturan
/// - Tombol Keluar di bagian bawah dengan konfirmasi logout terintegrasi
class MenuBarDrawer extends StatelessWidget {
  final VoidCallback? onNotificationTap;
  final VoidCallback? onSavedTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onLogoutTap;

  const MenuBarDrawer({
    super.key,
    this.onNotificationTap,
    this.onSavedTap,
    this.onSettingsTap,
    this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 220,
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFDBE6D5),
              Color(0xFFFBFCFA),
              Color(0xFFFBFCFA),
            ],
            stops: [0.0, 0.35, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // 1. Profil Pengguna Header: Avatar + Username
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: QcumberColors.cucumberGreen,
                          width: 1.5,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/feed/alexumber_avatar.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.person,
                            color: QcumberColors.primaryGreen,
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Alexumber',
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

              const SizedBox(height: 32),

              // 2. Daftar Menu Navigasi Utama
              _buildMenuItem(
                icon: Icons.notifications_none_rounded,
                title: 'Notifikasi',
                onTap: () {
                  final navigator = Navigator.of(context);
                  navigator.pop();
                  if (onNotificationTap != null) {
                    onNotificationTap!();
                  } else {
                    navigator.push(
                      MaterialPageRoute(
                        builder: (context) => const NotifikasiPage(),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 10),

              _buildMenuItem(
                icon: Icons.bookmark_border_rounded,
                title: 'Disimpan',
                onTap: () {
                  final navigator = Navigator.of(context);
                  navigator.pop();
                  if (onSavedTap != null) {
                    onSavedTap!();
                  } else {
                    navigator.push(
                      MaterialPageRoute(
                        builder: (context) => const DisimpanPage(),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 10),

              _buildMenuItem(
                icon: Icons.settings_outlined,
                title: 'Pengaturan',
                onTap: () {
                  final navigator = Navigator.of(context);
                  navigator.pop();
                  if (onSettingsTap != null) {
                    onSettingsTap!();
                  } else {
                    navigator.push(
                      MaterialPageRoute(
                        builder: (context) => const PengaturanPage(),
                      ),
                    );
                  }
                },
              ),

              const Spacer(),

              // 3. Tombol Logout / Keluar di Bagian Bawah
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: _buildMenuItem(
                  icon: Icons.logout_rounded,
                  title: 'Keluar',
                  color: const Color(0xFFC3423F),
                  onTap: () {
                    Navigator.pop(context);
                    if (onLogoutTap != null) {
                      onLogoutTap!();
                    } else {
                      showLogoutConfirmationDialog(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    final textColor = color ?? QcumberColors.primaryGreen;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: QcumberColors.cucumberGreen.withValues(alpha: 0.15),
        highlightColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Row(
            children: [
              Icon(icon, size: 22, color: textColor),
              const SizedBox(width: 14),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

