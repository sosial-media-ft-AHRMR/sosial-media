import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/qcumber_colors.dart';

/// Halaman Bantuan & Pengelolaan Akun Diblokir Qcumber
/// Konversi presisi 99% dari Desain Figma "Diblokir.png" & "Diblokir-1.png" (402 x 874)
class DiblokirHelpPage extends StatefulWidget {
  const DiblokirHelpPage({super.key});

  @override
  State<DiblokirHelpPage> createState() => _DiblokirHelpPageState();
}

class _DiblokirHelpPageState extends State<DiblokirHelpPage> {
  // Daftar akun yang diblokir sesuai desain Figma
  final List<Map<String, String>> _blockedUsers = [
    {
      'name': 'Gisela Anastasia',
      'username': 'gisel_la',
      'avatar': 'assets/feed/avatar_shawn.png',
    },
    {
      'name': 'Amanda Manopo',
      'username': 'amandamanopo',
      'avatar': 'assets/feed/avatar_your_idol.png',
    },
    {
      'name': 'Raffi Ahmad',
      'username': 'raffinagita1717',
      'avatar': 'assets/feed/avatar_peter.png',
    },
  ];

  void _unblockUser(int index) {
    final user = _blockedUsers[index];
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: Text(
          'Buka Blokir Akun?',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: QcumberColors.darkGreen,
          ),
        ),
        content: Text(
          'Apakah Anda yakin ingin membuka blokir @${user['username']}? Mereka akan dapat melihat kembali profil dan postingan Anda.',
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: QcumberColors.sageText,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Batal',
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: QcumberColors.primaryGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _blockedUsers.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Berhasil membuka blokir @${user['username']}',
                    style: GoogleFonts.poppins(fontSize: 13),
                  ),
                  backgroundColor: QcumberColors.primaryGreen,
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            child: Text(
              'Buka Blokir',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

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
                      'Diblokir',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: QcumberColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Daftar Pengguna yang Diblokir
              Expanded(
                child: _blockedUsers.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.block_flipped,
                              size: 54,
                              color: Color(0xFFC7E39F),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              'Belum ada akun yang diblokir',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: QcumberColors.darkGreen,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Akun yang Anda blokir akan muncul di daftar ini.',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: QcumberColors.sageText,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 8.0,
                        ),
                        itemCount: _blockedUsers.length,
                        separatorBuilder: (context, index) =>
                            const Divider(height: 24, thickness: 0.8),
                        itemBuilder: (context, index) {
                          final user = _blockedUsers[index];
                          return Row(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundImage: AssetImage(user['avatar']!),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user['name']!,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: QcumberColors.darkGreen,
                                      ),
                                    ),
                                    Text(
                                      '@${user['username']}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: QcumberColors.sageText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: QcumberColors.primaryGreen,
                                    width: 1.2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 6,
                                  ),
                                ),
                                onPressed: () => _unblockUser(index),
                                child: Text(
                                  'Buka Blokir',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: QcumberColors.primaryGreen,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

