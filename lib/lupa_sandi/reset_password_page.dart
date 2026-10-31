import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Halaman 3 Reset Password Baru sesuai desain Figma `figma/lupa sandi/Ubah sandi.png`
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  static const Color _primaryGreen = Color(0xFF165540);
  static const Color _disabledGreen = Color(0xFFB4CBAA);
  static const Color _infoBannerColor = Color(0xFF7E9F88);
  static const Color _fieldFillColor = Color(0xFFEAF1E6);

  bool get _isFormValid {
    final newPass = _newPasswordController.text;
    final confirmPass = _confirmPasswordController.text;
    return newPass.isNotEmpty && confirmPass.isNotEmpty && newPass == confirmPass;
  }

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_onTextChanged);
    _confirmPasswordController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _newPasswordController.removeListener(_onTextChanged);
    _confirmPasswordController.removeListener(_onTextChanged);
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    final newPass = _newPasswordController.text;
    final confirmPass = _confirmPasswordController.text;

    if (newPass.isEmpty || confirmPass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Harap isi semua kolom kata sandi',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          backgroundColor: _primaryGreen,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    if (newPass != confirmPass) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Konfirmasi kata sandi tidak cocok',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          backgroundColor: _primaryGreen,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    // Tampilkan notifikasi keberhasilan
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Kata sandi berhasil diubah! Silahkan masuk kembali.',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: _primaryGreen,
        duration: const Duration(seconds: 2),
      ),
    );

    // Kembali ke halaman Login
    Navigator.of(context).popUntil((route) => route.isFirst);
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
                      'Lupa Password',
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
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      // Banner Informasi Sesuai Figma
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: _infoBannerColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline_rounded,
                              color: Colors.black87,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Setelah kata sandi diubah, silahkan masuk kembali menggunakan kata sandi baru',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                  height: 1.35,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Label 1: Buat kata sandi baru
                      Text(
                        'Buat kata sandi baru',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _primaryGreen,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Field 1: Kata sandi baru
                      TextField(
                        controller: _newPasswordController,
                        obscureText: true,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        decoration: InputDecoration(
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

                      const SizedBox(height: 24),

                      // Label 2: Konfirmasi kata sandi baru
                      Text(
                        'Konfirmasi kata sandi baru',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _primaryGreen,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Field 2: Konfirmasi kata sandi baru
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        decoration: InputDecoration(
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

                      const SizedBox(height: 48),

                      // Tombol Stadium "Simpan Kata sandi Baru"
                      Center(
                        child: SizedBox(
                          width: 260,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _isFormValid ? _submit : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _primaryGreen,
                              disabledBackgroundColor: _disabledGreen,
                              elevation: 0,
                              shape: const StadiumBorder(),
                            ),
                            child: Text(
                              'Simpan Kata sandi Baru',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
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

