import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'masukkan_kata_sandi_dua_langkah_page.dart';

/// Halaman 1 Pengantar Verifikasi Dua Langkah sesuai desain Figma
/// "Verif 2 langkah.png" pada folder `figma/atur verikasi dua langkah`
class AturVerifikasiDuaLangkahPage extends StatelessWidget {
  const AturVerifikasiDuaLangkahPage({super.key});

  static const Color _primaryGreen = Color(0xFF165540);
  static const Color _subtitleGreen = Color(0xFF4A6B5D);

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
              // 1. Header: Tombol Kembali (<) + Judul "Verifikasi Dua Langkah"
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 16.0,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: _primaryGreen,
                        size: 22,
                      ),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      tooltip: 'Kembali',
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        'Verifikasi Dua Langkah',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: _primaryGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 1),

              // 2. Grafis Kunci & Gembok Hijau Presisi Figma
              Center(
                child: Image.asset(
                  'assets/feed/icon_two_factor_lock.png',
                  width: 120,
                  height: 140,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: _primaryGreen.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.lock_rounded,
                      size: 64,
                      color: _primaryGreen,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 36),

              // 3. Judul & Penjelasan
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    Text(
                      'Verifikasi Dua Langkah',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: _primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Anda dapat mengatur kata sandi kedua\nyang akan digunakan ketika anda login\nmelalui perangkat baru.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _subtitleGreen,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // 4. Tombol Aksi: "Atur Verifikasi Dua Langkah"
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MasukkanKataSandiDuaLangkahPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    child: Text(
                      'Atur Verifikasi Dua Langkah',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

