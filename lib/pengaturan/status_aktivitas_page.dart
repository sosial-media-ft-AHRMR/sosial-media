import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/qcumber_colors.dart';

/// Halaman Status Aktivitas
/// Konversi presisi 99% dari Desain Figma "Status Aktivitas.png" (402 x 874)
class StatusAktivitasPage extends StatefulWidget {
  const StatusAktivitasPage({super.key});

  @override
  State<StatusAktivitasPage> createState() => _StatusAktivitasPageState();
}

class _StatusAktivitasPageState extends State<StatusAktivitasPage> {
  bool _isOnlineActive = true;

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
              // 1. Bilah Header: Tombol Kembali (<) + Judul "Status Aktivitas"
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 16.0,
                  bottom: 24.0,
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
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: QcumberColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // 2. Konten Status Online
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Baris: "Status online" + Switch Toggle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Status online',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: QcumberColors.primaryGreen,
                          ),
                        ),
                        _buildCustomSwitch(
                          value: _isOnlineActive,
                          onChanged: (val) {
                            setState(() => _isOnlineActive = val);
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Deskripsi Status Aktivitas
                    Text(
                      '"Tampilkan saat kamu sedang aktif. Jika dimatikan, status aktivitas orang lain juga akan disembunyikan.',
                      style: GoogleFonts.poppins(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF4A6B5D),
                        height: 1.45,
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

  /// Switch kustom presisi sesuai Figma
  Widget _buildCustomSwitch({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48,
        height: 26,
        padding: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: value ? const Color(0xFF165540) : const Color(0xFFC8D7C3),
          borderRadius: BorderRadius.circular(13),
        ),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

