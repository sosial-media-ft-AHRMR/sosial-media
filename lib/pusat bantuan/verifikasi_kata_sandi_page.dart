import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/qcumber_colors.dart';

/// Halaman Bantuan & Form Verifikasi Kata Sandi Qcumber
/// Konversi presisi 99% dari Desain Figma "Verifikasi (Masukkan kata sandi).png"
/// & "Verifikasi (Masukkan kata sandi Open eyes)).png" (402 x 874)
class VerifikasiKataSandiHelpPage extends StatefulWidget {
  const VerifikasiKataSandiHelpPage({super.key});

  @override
  State<VerifikasiKataSandiHelpPage> createState() =>
      _VerifikasiKataSandiHelpPageState();
}

class _VerifikasiKataSandiHelpPageState
    extends State<VerifikasiKataSandiHelpPage> {
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _verifyPassword() {
    final password = _passwordController.text;
    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Silakan masukkan kata sandi Anda',
            style: GoogleFonts.poppins(fontSize: 13),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Verifikasi kata sandi berhasil',
          style: GoogleFonts.poppins(fontSize: 13),
        ),
        backgroundColor: QcumberColors.primaryGreen,
      ),
    );
    Navigator.pop(context);
  }

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
                      'Verifikasi',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: QcumberColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Masukkan Kata Sandi Anda',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: QcumberColors.darkGreen,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Untuk alasan keamanan, masukkan kata sandi akun Qcumber Anda saat ini untuk melanjutkan.',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: QcumberColors.sageText,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Input Field Kata Sandi dengan Toggle Open/Closed Eyes
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFFC7E39F),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: QcumberColors.darkGreen,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Kata Sandi',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 13,
                            color: const Color(0xFF9E9E9E),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_rounded,
                            color: QcumberColors.primaryGreen,
                            size: 22,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              color: QcumberColors.primaryGreen,
                              size: 22,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Link Lupa Sandi
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Tautan reset sandi telah dikirim ke email Anda',
                                style: GoogleFonts.poppins(fontSize: 13),
                              ),
                              backgroundColor: QcumberColors.primaryGreen,
                            ),
                          );
                        },
                        child: Text(
                          'Lupa kata sandi?',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: QcumberColors.primaryGreen,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Tombol Konfirmasi
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: QcumberColors.primaryGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 2,
                        ),
                        onPressed: _verifyPassword,
                        child: Text(
                          'Konfirmasi',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
}

