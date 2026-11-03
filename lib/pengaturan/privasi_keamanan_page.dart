import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../atur_verifikasi_dua_langkah/atur_verifikasi_dua_langkah.dart';
import '../mode_gelap_terang/theme_controller.dart';
import '../theme/qcumber_colors.dart';
import '../ubah_sandi/ubah_sandi_page.dart';
import 'tempat_login_page.dart';

/// Halaman Privasi dan Keamanan
/// Konversi presisi 99% dari Desain Figma "Privasi dan Keamanan.png" (402 x 874)
/// Dilengkapi fitur "ubah mode" untuk beralih antara Mode Gelap dan Mode Terang
class PrivasiKeamananPage extends StatelessWidget {
  const PrivasiKeamananPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.instance;

    return ListenableBuilder(
      listenable: themeController,
      builder: (context, _) {
        final isDark = themeController.isDarkMode;

        return Scaffold(
          backgroundColor: isDark ? const Color(0xFF1E2319) : Colors.white,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: themeController.settingsGradient,
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Bilah Header: Tombol Kembali (<) + Judul 2 Baris "Privasi dan Keamanan"
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 16.0,
                      bottom: 24.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: themeController.primaryTextColor,
                              size: 22,
                            ),
                            onPressed: () => Navigator.pop(context),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            'Privasi dan\nKeamanan',
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: themeController.primaryTextColor,
                              height: 1.15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 2. Daftar Menu Keamanan & Pengaturan Mode
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _buildNavItem(
                          title: 'Ubah kata sandi',
                          textColor: themeController.primaryTextColor,
                          iconColor: themeController.primaryTextColor,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UbahSandiPage(),
                              ),
                            );
                          },
                        ),
                        _buildDivider(themeController.dividerColor),
                        _buildNavItem(
                          title: 'Verifikasi dua langkah',
                          textColor: themeController.primaryTextColor,
                          iconColor: themeController.primaryTextColor,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AturVerifikasiDuaLangkahPage(),
                              ),
                            );
                          },
                        ),
                        _buildDivider(themeController.dividerColor),
                        _buildNavItem(
                          title: 'Tempat anda login',
                          textColor: themeController.primaryTextColor,
                          iconColor: themeController.primaryTextColor,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TempatLoginPage(),
                              ),
                            );
                          },
                        ),
                        _buildDivider(themeController.dividerColor),

                        // Fitur Baru: ubah mode (sesuai Figma Privasi dan Keamanan.png)
                        _buildModeToggleItem(
                          context: context,
                          title: 'ubah mode',
                          isDark: isDark,
                          textColor: themeController.primaryTextColor,
                          onToggle: (val) {
                            themeController.setDarkMode(val);
                          },
                        ),
                        _buildDivider(themeController.dividerColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem({
    required String title,
    required Color textColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: QcumberColors.cucumberGreen.withValues(alpha: 0.15),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
                color: iconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Item menu "ubah mode" dengan switch toggle sesuai desain Figma
  Widget _buildModeToggleItem({
    required BuildContext context,
    required String title,
    required bool isDark,
    required Color textColor,
    required ValueChanged<bool> onToggle,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onToggle(!isDark),
        splashColor: QcumberColors.cucumberGreen.withValues(alpha: 0.15),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
              _buildCustomSwitch(
                value: isDark,
                onChanged: onToggle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Switch toggle kustom presisi sesuai Figma (pill hijau dengan thumb lingkaran putih)
  Widget _buildCustomSwitch({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48,
        height: 26,
        padding: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: value ? const Color(0xFF165540) : const Color(0xFFC8D7C3),
          borderRadius: BorderRadius.circular(13),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(Color dividerColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Divider(
        height: 1,
        thickness: 1,
        color: dividerColor,
      ),
    );
  }
}
