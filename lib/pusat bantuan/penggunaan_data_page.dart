import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/qcumber_colors.dart';

/// Halaman Bantuan & Pengaturan Penggunaan Data Qcumber
/// Konversi presisi 99% dari Desain Figma "Penggunaan Data.png" (402 x 874)
class PenggunaanDataHelpPage extends StatefulWidget {
  const PenggunaanDataHelpPage({super.key});

  @override
  State<PenggunaanDataHelpPage> createState() => _PenggunaanDataHelpPageState();
}

class _PenggunaanDataHelpPageState extends State<PenggunaanDataHelpPage> {
  bool _dataSaver = false;
  bool _highQualityUpload = true;
  String _highResMedia = 'Hanya Wi-Fi';

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
                      'Penggunaan Data',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
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
                    // 1. Toggle Penghemat Data
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Penghemat Data',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: QcumberColors.darkGreen,
                          ),
                        ),
                        Switch(
                          value: _dataSaver,
                          activeTrackColor: QcumberColors.primaryGreen,
                          activeThumbColor: Colors.white,
                          inactiveTrackColor: const Color(0xFFD9D9D9),
                          inactiveThumbColor: Colors.white,
                          onChanged: (val) {
                            setState(() => _dataSaver = val);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Saat Penghemat Data diaktifkan, video tidak akan dimuat terlebih dahulu untuk membantu menghemat kuota data seluler Anda.',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: QcumberColors.sageText,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Divider(thickness: 0.8),
                    const SizedBox(height: 14),

                    // 2. Media Resolusi Tinggi
                    Text(
                      'Media Beresolusi Tinggi',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: QcumberColors.darkGreen,
                      ),
                    ),
                    const SizedBox(height: 10),

                    _buildRadioOption('Tidak Pernah'),
                    _buildRadioOption('Hanya Wi-Fi'),
                    _buildRadioOption('Seluler + Wi-Fi'),

                    const SizedBox(height: 14),
                    const Divider(thickness: 0.8),
                    const SizedBox(height: 14),

                    // 3. Kualitas Unggahan Media
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Unggah Kualitas Tertinggi',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: QcumberColors.darkGreen,
                          ),
                        ),
                        Switch(
                          value: _highQualityUpload,
                          activeTrackColor: QcumberColors.primaryGreen,
                          activeThumbColor: Colors.white,
                          inactiveTrackColor: const Color(0xFFD9D9D9),
                          inactiveThumbColor: Colors.white,
                          onChanged: (val) {
                            setState(() => _highQualityUpload = val);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Selalu unggah foto dan video dalam resolusi terbaik, meskipun memerlukan waktu lebih lama dan menggunakan lebih banyak data.',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: QcumberColors.sageText,
                        height: 1.5,
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

  Widget _buildRadioOption(String value) {
    final bool isSelected = _highResMedia == value;
    return InkWell(
      onTap: () {
        setState(() => _highResMedia = value);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
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
            const SizedBox(width: 12),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? QcumberColors.darkGreen
                    : QcumberColors.sageText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

