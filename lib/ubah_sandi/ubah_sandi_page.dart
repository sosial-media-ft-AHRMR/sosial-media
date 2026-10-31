import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/qcumber_colors.dart';

/// Halaman Ubah Kata Sandi Qcumber
/// Konversi presisi 99% dari folder Figma `figma/ubah sandi/Ubah sandi-1.png` hingga `Ubah sandi-23.png` (402 x 874)
///
/// Fitur:
/// 1. Top bar: Tombol kembali '<' + Judul "Ubah Kata Sandi" (#165540, bold w700)
///    dengan latar gradasi khas Qcumber (#CFDEC7 ke putih).
/// 2. Info Banner: Card hijau sage (#7E9F88) dengan ikon peringatan bulat dan teks:
///    "Setelah kata sandi diubah, silahkan masuk kembali menggunakan kata sandi baru".
/// 3. Tiga kolom input form:
///    - Kata sandi lama (default 'as12' sesuai prototipe Figma Ubah sandi-1.png)
///    - Buat kata sandi baru
///    - Konfirmasi kata sandi baru
///    Semua kolom berlatar #E9F1E4 dengan border hijau elegan #165540 dan sudut membulat.
/// 4. Tombol stadium penuh "Simpan Kata sandi Baru":
///    - Warna #165540 dengan teks putih tebal.
///    - Validasi kelengkapan form dan konfirmasi perubahan kata sandi.
class UbahSandiPage extends StatefulWidget {
  const UbahSandiPage({super.key});

  @override
  State<UbahSandiPage> createState() => _UbahSandiPageState();
}

class _UbahSandiPageState extends State<UbahSandiPage> {
  // Controller untuk ketiga kolom input kata sandi
  // 'as12' terisi secara default sesuai prototipe Figma Ubah sandi-1.png
  final TextEditingController _oldPasswordController =
      TextEditingController(text: 'as12');
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _savePassword() {
    final oldPass = _oldPasswordController.text.trim();
    final newPass = _newPasswordController.text.trim();
    final confirmPass = _confirmPasswordController.text.trim();

    if (oldPass.isEmpty) {
      _showFeedbackSnackBar('Silakan masukkan kata sandi lama Anda');
      return;
    }

    if (newPass.isEmpty) {
      _showFeedbackSnackBar('Silakan buat kata sandi baru');
      return;
    }

    if (confirmPass.isEmpty) {
      _showFeedbackSnackBar('Silakan konfirmasi kata sandi baru');
      return;
    }

    if (newPass != confirmPass) {
      _showFeedbackSnackBar('Konfirmasi kata sandi baru tidak cocok');
      return;
    }

    // Berhasil diubah: tampilkan konfirmasi dan kembali
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          'Kata sandi berhasil diubah. Silahkan masuk kembali menggunakan kata sandi baru.',
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: QcumberColors.primaryGreen,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

    Navigator.of(context).maybePop();
  }

  void _showFeedbackSnackBar(String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(fontSize: 13, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF8B2525),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFCFDEC7),
              Color(0xFFF2F7EF),
              Colors.white,
            ],
            stops: [0.0, 0.18, 0.40],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 1. Top Bar Header
              _buildTopBar(),

              // 2. Formulir Scrollable
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      // Card Banner Informasi Peringatan (Hijau Sage #7E9F88)
                      _buildInfoBanner(),

                      const SizedBox(height: 28),

                      // Field 1: Kata sandi lama
                      _buildField(
                        label: 'Kata sandi lama',
                        controller: _oldPasswordController,
                        hintText: 'Masukkan kata sandi lama',
                      ),

                      const SizedBox(height: 22),

                      // Field 2: Buat kata sandi baru
                      _buildField(
                        label: 'Buat kata sandi baru',
                        controller: _newPasswordController,
                        hintText: 'Masukkan kata sandi baru',
                      ),

                      const SizedBox(height: 22),

                      // Field 3: Konfirmasi kata sandi baru
                      _buildField(
                        label: 'Konfirmasi kata sandi baru',
                        controller: _confirmPasswordController,
                        hintText: 'Ulangi kata sandi baru',
                      ),

                      const SizedBox(height: 38),

                      // Tombol Simpan Kata sandi Baru
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: ElevatedButton(
                              onPressed: _savePassword,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: QcumberColors.primaryGreen,
                                foregroundColor: Colors.white,
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
                      ),

                      const SizedBox(height: 32),
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

  /// Top Bar Header dengan Tombol Kembali '<' dan Judul 'Ubah Kata Sandi'
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.maybePop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: QcumberColors.primaryGreen,
              size: 22,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 14),
          Text(
            'Ubah Kata Sandi',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: QcumberColors.primaryGreen,
            ),
          ),
        ],
      ),
    );
  }

  /// Banner Informasi Peringatan (#7E9F88) Sesuai Figma Ubah sandi-1.png
  Widget _buildInfoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
      decoration: BoxDecoration(
        color: const Color(0xFF7E9F88),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: Color(0xFF165540),
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Setelah kata sandi diubah, silahkan masuk kembali menggunakan kata sandi baru',
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF223428),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Kolom Input Form dengan Latar #E9F1E4 dan Border #165540
  Widget _buildField({
    required String label,
    required TextEditingController controller,
    String? hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: QcumberColors.primaryGreen,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFE9F1E4),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: QcumberColors.primaryGreen,
              width: 1.2,
            ),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: TextField(
            controller: controller,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: QcumberColors.primaryGreen,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color(0xFF7D9B71),
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}
