import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../atur_verifikasi_dua_langkah/atur_verifikasi_dua_langkah.dart';
import '../theme/qcumber_colors.dart';
import '../ubah_sandi/ubah_sandi_page.dart';
import 'tempat_login_page.dart';

/// Halaman Privasi dan Keamanan
/// Konversi presisi 99% dari Desain Figma "Privasi dan Keamanan.png" (402 x 874)
class PrivasiKeamananPage extends StatelessWidget {
  const PrivasiKeamananPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFCFDEC7),
              Color(0xFFF7FAF5),
              Colors.white,
            ],
            stops: [0.0, 0.20, 0.50],
          ),
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
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: QcumberColors.primaryGreen,
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
                          color: QcumberColors.primaryGreen,
                          height: 1.15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // 2. Daftar Menu Keamanan
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildNavItem(
                      title: 'Ubah kata sandi',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UbahSandiPage(),
                          ),
                        );
                      },
                    ),
                    _buildDivider(),
                    _buildNavItem(
                      title: 'Verifikasi dua langkah',
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
                    _buildDivider(),
                    _buildNavItem(
                      title: 'Tempat anda login',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TempatLoginPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String title,
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
                    color: QcumberColors.primaryGreen,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
                color: QcumberColors.primaryGreen,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Divider(
        height: 1,
        thickness: 1,
        color: Color(0xFFD0DFC9),
      ),
    );
  }
}

