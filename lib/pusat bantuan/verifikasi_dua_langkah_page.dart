import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/qcumber_colors.dart';
import '../widgets/popups/two_factor_success_dialog.dart';

/// Halaman Bantuan & Konfigurasi Verifikasi 2 Langkah Qcumber
/// Konversi presisi 99% dari Desain Figma "Verif 2 langkah.png" (402 x 874)
class VerifikasiDuaLangkahHelpPage extends StatefulWidget {
  const VerifikasiDuaLangkahHelpPage({super.key});

  @override
  State<VerifikasiDuaLangkahHelpPage> createState() =>
      _VerifikasiDuaLangkahHelpPageState();
}

class _VerifikasiDuaLangkahHelpPageState
    extends State<VerifikasiDuaLangkahHelpPage> {
  bool _is2FAEnabled = false;
  String _selectedMethod = 'WhatsApp / SMS';

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
                      'Verifikasi Dua Langkah',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: QcumberColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22.0,
                    vertical: 8.0,
                  ),
                  children: [
                    // Ilustrasi Keamanan
                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F6EC),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFC7E39F),
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.verified_user_rounded,
                          size: 44,
                          color: QcumberColors.primaryGreen,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      'Amankan Akun Anda',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: QcumberColors.darkGreen,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Verifikasi dua langkah membantu melindungi akun Anda dengan meminta kode verifikasi saat Anda masuk di perangkat yang tidak dikenal.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: QcumberColors.sageText,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 24),
                    const Divider(thickness: 0.8),
                    const SizedBox(height: 12),

                    // Toggle Pengaktifan
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Aktifkan Verifikasi',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: QcumberColors.darkGreen,
                          ),
                        ),
                        Switch(
                          value: _is2FAEnabled,
                          activeTrackColor: QcumberColors.primaryGreen,
                          activeThumbColor: Colors.white,
                          inactiveTrackColor: const Color(0xFFD9D9D9),
                          inactiveThumbColor: Colors.white,
                          onChanged: (val) {
                            setState(() => _is2FAEnabled = val);
                            if (val) {
                              showTwoFactorSuccessDialog(context);
                            }
                          },
                        ),
                      ],
                    ),

                    if (_is2FAEnabled) ...[
                      const SizedBox(height: 20),
                      Text(
                        'Pilih Metode Keamanan',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: QcumberColors.primaryGreen,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildMethodTile(
                        title: 'Pesan Teks (SMS / WhatsApp)',
                        subtitle:
                            'Kode verifikasi akan dikirim ke nomor telepon Anda',
                        value: 'WhatsApp / SMS',
                        icon: Icons.sms_outlined,
                      ),
                      const SizedBox(height: 8),
                      _buildMethodTile(
                        title: 'Aplikasi Autentikator',
                        subtitle:
                            'Gunakan Google Authenticator atau aplikasi sejenis',
                        value: 'Aplikasi Autentikator',
                        icon: Icons.phonelink_lock_rounded,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMethodTile({
    required String title,
    required String subtitle,
    required String value,
    required IconData icon,
  }) {
    final isSelected = _selectedMethod == value;
    return InkWell(
      onTap: () => setState(() => _selectedMethod = value),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? QcumberColors.primaryGreen
                : const Color(0xFFE2E8F0),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? QcumberColors.primaryGreen
                  : QcumberColors.sageText,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: QcumberColors.darkGreen,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: QcumberColors.sageText,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? QcumberColors.primaryGreen
                      : const Color(0xFFBEBEBE),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: QcumberColors.primaryGreen,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

