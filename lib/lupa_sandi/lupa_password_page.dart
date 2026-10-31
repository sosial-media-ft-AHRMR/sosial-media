import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'verifikasi_email_page.dart';

/// Halaman 1 Lupa Password sesuai desain Figma `figma/lupa sandi/Lupa password.png`
class LupaPasswordPage extends StatefulWidget {
  const LupaPasswordPage({super.key});

  @override
  State<LupaPasswordPage> createState() => _LupaPasswordPageState();
}

class _LupaPasswordPageState extends State<LupaPasswordPage> {
  final TextEditingController _inputController = TextEditingController();
  bool _isPhoneMode = false;

  static const Color _primaryGreen = Color(0xFF165540);
  static const Color _fieldFillColor = Color(0xFFEAF1E6);
  static const Color _hintTextColor = Color(0xFF7D9B71);

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _submit() {
    final value = _inputController.text.trim();
    if (value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isPhoneMode
                ? 'Harap masukkan nomor handphone anda'
                : 'Harap masukkan alamat email anda',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          backgroundColor: _primaryGreen,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerifikasiEmailPage(
          identifier: value,
          isPhone: _isPhoneMode,
        ),
      ),
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
              Color(0xFFF2F7EF),
              Colors.white,
            ],
            stops: [0.0, 0.35, 0.7],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: _primaryGreen,
                        size: 22,
                      ),
                      onPressed: () => Navigator.pop(context),
                      tooltip: 'Kembali',
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Lupa password',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: _primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),

              // Content Area
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 36),

                      // Ilustrasi Gembok Lupa Password Sesuai Figma
                      Image.asset(
                        'assets/feed/icon_lupa_sandi_lock.png',
                        width: 128,
                        height: 160,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 128,
                          height: 160,
                          decoration: BoxDecoration(
                            color: _primaryGreen,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.lock_outline_rounded,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Judul
                      Text(
                        _isPhoneMode ? 'Nomor Handphone' : 'Alamat email',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: _primaryGreen,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 10),

                      // Subjudul
                      Text(
                        _isPhoneMode
                            ? 'Silahkan masukkan nomor handphone anda untuk menerima nomor verifikasi.'
                            : 'Silahkan masukkan alamat email anda untuk menerima nomor verifikasi.',
                        style: GoogleFonts.poppins(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          height: 1.45,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 32),

                      // Input Field
                      TextField(
                        controller: _inputController,
                        keyboardType: _isPhoneMode
                            ? TextInputType.phone
                            : TextInputType.emailAddress,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        decoration: InputDecoration(
                          hintText: _isPhoneMode
                              ? 'Masukkan nomor handphone anda'
                              : 'Masukkan email anda',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            color: _hintTextColor,
                            fontWeight: FontWeight.w400,
                          ),
                          filled: true,
                          fillColor: _fieldFillColor,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: _primaryGreen,
                              width: 1.2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: _primaryGreen,
                              width: 1.6,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Tautan Beralih "Coba cara lain"
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isPhoneMode = !_isPhoneMode;
                            _inputController.clear();
                          });
                        },
                        child: Text(
                          'Coba cara lain',
                          style: GoogleFonts.poppins(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            color: _primaryGreen,
                          ),
                        ),
                      ),

                      const SizedBox(height: 36),

                      // Tombol Stadium "Kirim"
                      SizedBox(
                        width: 250,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryGreen,
                            elevation: 0,
                            shape: const StadiumBorder(),
                          ),
                          child: Text(
                            'Kirim',
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
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

