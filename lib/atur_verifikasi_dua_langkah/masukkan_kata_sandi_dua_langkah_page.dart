import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../lupa_sandi/lupa_sandi.dart';
import '../widgets/popups/two_factor_success_dialog.dart';

/// Halaman 2 Masukkan Kata Sandi Verifikasi Dua Langkah sesuai desain Figma
/// "Verifikasi (Masukkan kata sandi).png" dan "Verifikasi (Masukkan kata sandi Open eyes)).png"
class MasukkanKataSandiDuaLangkahPage extends StatefulWidget {
  final String? pageTitle;
  final String? subtitleText;
  final String? confirmButtonText;

  const MasukkanKataSandiDuaLangkahPage({
    super.key,
    this.pageTitle,
    this.subtitleText,
    this.confirmButtonText,
  });

  @override
  State<MasukkanKataSandiDuaLangkahPage> createState() =>
      _MasukkanKataSandiDuaLangkahPageState();
}

class _MasukkanKataSandiDuaLangkahPageState
    extends State<MasukkanKataSandiDuaLangkahPage> {
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  static const Color _primaryGreen = Color(0xFF165540);
  static const Color _subtitleGreen = Color(0xFF335C4A);
  static const Color _fieldFillColor = Color(0xFFE8EFE5);
  static const Color _hintTextColor = Color(0xFF6B8A7A);

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    final password = _passwordController.text.trim();
    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Silakan masukkan kata sandi terlebih dahulu',
            style: GoogleFonts.poppins(fontSize: 13, color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    // Tampilkan popup sukses "Kata sandi verifikasi dua langkah anda berhasil dibuat"
    showTwoFactorSuccessDialog(
      context,
      onContinue: () {
        // Kembali ke halaman Privasi dan Keamanan
        Navigator.pop(context);
      },
    );
  }

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
              // 1. Header: Tombol Kembali (<) + Judul
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
                        widget.pageTitle ?? 'Verifikasi Dua Langkah',
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

              const SizedBox(height: 16),

              // 2. Subtitle: "Masukan kata sandi verifikasi yang telah anda buat"
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Center(
                  child: Text(
                    widget.subtitleText ??
                        'Masukan kata sandi verifikasi yang\ntelah anda buat',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: _subtitleGreen,
                      height: 1.4,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 36),

              // 3. Kolom Input Kata Sandi dengan Toggle Mata (Eye / Eye-off)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: _fieldFillColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _primaryGreen,
                      width: 1.2,
                    ),
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    style: GoogleFonts.poppins(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w500,
                      color: _primaryGreen,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Masukan kata sandi',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        color: _hintTextColor,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 14.0,
                      ),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: _primaryGreen,
                          size: 22,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // 4. Tautan "Lupa sandi?" sesuai aset Lupa sandi.png pada folder Figma
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LupaPasswordPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Lupa sandi?',
                      style: GoogleFonts.poppins(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                        color: _primaryGreen,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // 5. Tombol "Konfirmasi"
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      widget.confirmButtonText ?? 'Konfirmasi',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
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

