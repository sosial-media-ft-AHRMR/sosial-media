import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/qcumber_colors.dart';

/// Halaman Akun yang Diblokir
/// Konversi presisi 99% dari Desain Figma "Diblokir.png" dan "Diblokir-1.png" (402 x 874)
class DiblokirPage extends StatefulWidget {
  const DiblokirPage({super.key});

  @override
  State<DiblokirPage> createState() => _DiblokirPageState();
}

class _DiblokirPageState extends State<DiblokirPage> {
  // Daftar akun yang diblokir (Sesuai Figma: William)
  final List<Map<String, String>> _blockedAccounts = [
    {
      'name': 'William',
      'avatar': 'assets/feed/avatar_william.png',
    },
  ];

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
              // 1. Bilah Header: Tombol Kembali (<) + Judul "Akun yang diblokir"
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
                      'Akun yang diblokir',
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

              // 2. Daftar Akun atau Tampilan Kosong (Sesuai State Figma Diblokir.png / Diblokir-1.png)
              Expanded(
                child: _blockedAccounts.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        itemCount: _blockedAccounts.length,
                        itemBuilder: (context, index) {
                          final item = _blockedAccounts[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                // Avatar Pengguna Diblokir
                                Container(
                                  width: 52,
                                  height: 52,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      item['avatar']!,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                        Icons.account_circle,
                                        size: 52,
                                        color: QcumberColors.primaryGreen,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),

                                // Nama Pengguna
                                Expanded(
                                  child: Text(
                                    item['name']!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: QcumberColors.primaryGreen,
                                    ),
                                  ),
                                ),

                                // Tombol Berhenti Blokir (Pill Hijau Tua)
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      final removedName = item['name']!;
                                      setState(() {
                                        _blockedAccounts.removeAt(index);
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Berhenti memblokir $removedName',
                                            style: GoogleFonts.poppins(
                                              fontSize: 13,
                                            ),
                                          ),
                                          backgroundColor:
                                              QcumberColors.primaryGreen,
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14.0,
                                        vertical: 8.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF165540),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'Berhenti Blokir',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : Center(
                        // Tampilan Kosong Sesuai Diblokir-1.png
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Text(
                            'Tidak ada akun yang diblokir',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF4A6B5D),
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

