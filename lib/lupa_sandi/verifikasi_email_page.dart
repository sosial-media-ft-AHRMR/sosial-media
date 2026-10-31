import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'reset_password_page.dart';

/// Halaman 2 Verifikasi Email / Nomor HP sesuai desain Figma `figma/lupa sandi/Verifikasi email.png`
class VerifikasiEmailPage extends StatefulWidget {
  final String identifier;
  final bool isPhone;

  const VerifikasiEmailPage({
    super.key,
    required this.identifier,
    this.isPhone = false,
  });

  @override
  State<VerifikasiEmailPage> createState() => _VerifikasiEmailPageState();
}

class _VerifikasiEmailPageState extends State<VerifikasiEmailPage> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  static const Color _primaryGreen = Color(0xFF165540);
  static const Color _disabledGreen = Color(0xFFB4CBAA);
  static const Color _boxFillColor = Color(0xFFD6DBD4);

  bool get _isOtpComplete {
    return _controllers.every((c) => c.text.trim().isNotEmpty);
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 3) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    } else {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
    setState(() {});
  }

  void _submit() {
    if (!_isOtpComplete) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Silahkan masukkan 4 digit kode verifikasi',
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
        builder: (context) => const ResetPasswordPage(),
      ),
    );
  }

  void _resendCode() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.isPhone
              ? 'Kode verifikasi baru telah dikirimkan ke nomor hp anda'
              : 'Kode verifikasi baru telah dikirimkan ke email anda',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: _primaryGreen,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isPhone ? 'Verifikasi nomor hp' : 'Verifikasi email';
    final subtitle = widget.isPhone
        ? 'Silahkan masukkan kode 4 digit yang telah dikirimkan ke nomor hp anda'
        : 'Silahkan masukkan kode 4 digit yang telah dikirimkan ke email anda';

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
                      title,
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

                      // Ilustrasi Amplop Email & Paperclip Sesuai Figma
                      Image.asset(
                        'assets/feed/icon_verifikasi_email.png',
                        width: 140,
                        height: 130,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 140,
                          height: 130,
                          decoration: BoxDecoration(
                            color: _primaryGreen,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.email_outlined,
                              size: 70,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Judul
                      Text(
                        'Kode verifikasi',
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
                        subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          height: 1.45,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 34),

                      // 4 Kotak Digit Kode Verifikasi
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (index) {
                          return Container(
                            width: 52,
                            height: 66,
                            margin: const EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              color: _boxFillColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: _controllers[index],
                              focusNode: _focusNodes[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                              decoration: const InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              onChanged: (value) => _onDigitChanged(index, value),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 18),

                      // Tautan "Kirim ulang kode"
                      GestureDetector(
                        onTap: _resendCode,
                        child: Text(
                          'Kirim ulang kode',
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
                          onPressed: _isOtpComplete ? _submit : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryGreen,
                            disabledBackgroundColor: _disabledGreen,
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

