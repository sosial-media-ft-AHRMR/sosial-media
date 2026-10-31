import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/qcumber_colors.dart';

/// Halaman Bantuan & Pengaturan Status Aktivitas Qcumber
/// Konversi presisi 99% dari Desain Figma "Status Aktivitas.png" (402 x 874)
class StatusAktivitasHelpPage extends StatefulWidget {
  const StatusAktivitasHelpPage({super.key});

  @override
  State<StatusAktivitasHelpPage> createState() =>
      _StatusAktivitasHelpPageState();
}

class _StatusAktivitasHelpPageState extends State<StatusAktivitasHelpPage> {
  bool _showActivityStatus = true;

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
                      'Status Aktivitas',
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

              // Baris Toggle "Tampilkan Status Aktivitas"
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Tampilkan Status Aktivitas',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: QcumberColors.darkGreen,
                        ),
                      ),
                    ),
                    Switch(
                      value: _showActivityStatus,
                      activeTrackColor: QcumberColors.primaryGreen,
                      activeThumbColor: Colors.white,
                      inactiveTrackColor: const Color(0xFFD9D9D9),
                      inactiveThumbColor: Colors.white,
                      onChanged: (val) {
                        setState(() {
                          _showActivityStatus = val;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _showActivityStatus
                                  ? 'Status aktivitas diaktifkan'
                                  : 'Status aktivitas dinonaktifkan',
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
                  'Izinkan akun yang Anda ikuti dan siapa saja yang Anda kirimi pesan melihat kapan Anda terakhir aktif atau sedang aktif di aplikasi Qcumber.\n\n'
                  'Saat fitur ini dinonaktifkan, Anda tidak akan dapat melihat status aktivitas orang lain.',
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

