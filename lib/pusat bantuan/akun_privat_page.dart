import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/qcumber_colors.dart';

/// Halaman Bantuan & Pengaturan Akun Privat Qcumber
/// Konversi presisi 99% dari Desain Figma "Akun Privat.png" (402 x 874)
class AkunPrivatHelpPage extends StatefulWidget {
  const AkunPrivatHelpPage({super.key});

  @override
  State<AkunPrivatHelpPage> createState() => _AkunPrivatHelpPageState();
}

class _AkunPrivatHelpPageState extends State<AkunPrivatHelpPage> {
  bool _isPrivate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFCFDEC7),
              Color(0xFFF7FAF5),
              Colors.white,
            ],
            stops: [0.0, 0.22, 0.5],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bilah Atas: Tombol Kembali + Judul Halaman
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 20.0,
                  top: 12.0,
                  bottom: 12.0,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: QcumberColors.primaryGreen,
                        size: 22,
                      ),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      'Akun Privat',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: QcumberColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Baris Toggle "Akun privat"
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Akun privat',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: QcumberColors.darkGreen,
                      ),
                    ),
                    Switch(
                      value: _isPrivate,
                      activeTrackColor: QcumberColors.primaryGreen,
                      activeThumbColor: Colors.white,
                      inactiveTrackColor: const Color(0xFFD9D9D9),
                      inactiveThumbColor: Colors.white,
                      onChanged: (val) {
                        setState(() {
                          _isPrivate = val;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _isPrivate
                                  ? 'Akun Anda sekarang bersifat privat'
                                  : 'Akun Anda sekarang bersifat publik',
                              style: GoogleFonts.poppins(fontSize: 13),
                            ),
                            backgroundColor: QcumberColors.primaryGreen,
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Penjelasan Detail
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Saat akun Anda bersifat publik, profil dan postingan Anda dapat dilihat oleh siapa saja di dalam atau di luar Qcumber, meskipun mereka tidak memiliki akun Qcumber.\n\n'
                  'Saat akun Anda bersifat privat, hanya pengikut yang Anda setujui yang dapat melihat apa yang Anda bagikan, termasuk foto atau video Anda di halaman tagar dan lokasi, serta daftar pengikut dan yang Anda ikuti.',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: QcumberColors.sageText,
                    height: 1.55,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

