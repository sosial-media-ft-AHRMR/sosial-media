import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/story_item.dart';

/// Halaman Pratinjau Cerita (Story) Sesuai 100% dengan Figma New Post.png
/// Fitur:
/// - Pratinjau foto layar penuh (Foto kue angsa Figma atau foto yang dipilih)
/// - Tombol kembali (<) di pojok kiri atas
/// - Bilah aksi bawah dengan tombol "Batalkan" dan tombol "cerita anda" lengkap dengan avatar pengguna
class StoryPreviewPage extends StatelessWidget {
  final String imagePath;
  final String userAvatarUrl;

  const StoryPreviewPage({
    super.key,
    this.imagePath = 'assets/feed/cake_swan.png',
    this.userAvatarUrl = 'assets/feed/avatar_qcumber.jpg',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Tampilan Foto Cerita Layar Penuh (Mendukung Aset & File Kamera/Galeri)
          Positioned.fill(
            child: _buildPreviewImage(imagePath),
          ),

          // 2. Tombol Kembali (<) di Kiri Atas
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 18,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFDEEBCE).withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color(0xFF165540),
                  size: 18,
                ),
              ),
            ),
          ),

          // 3. Bilah Navigasi Bawah (Batalkan & Cerita Anda)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                20,
                14,
                20,
                MediaQuery.of(context).padding.bottom + 14,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  // Tombol "Batalkan"
                  Expanded(
                    child: SizedBox(
                      height: 42,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDEEBCE),
                          foregroundColor: const Color(0xFF165540),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                        child: Text(
                          'Batalkan',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Tombol "cerita anda" dengan Avatar Pengguna
                  Expanded(
                    child: SizedBox(
                      height: 42,
                      child: ElevatedButton(
                        onPressed: () {
                          // Menambahkan cerita ke daftar story aktif secara terpusat
                          StoryRepository.addMyStory(
                            imagePath: imagePath,
                            username: 'Cerita Anda',
                            avatarUrl: userAvatarUrl,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Cerita Anda berhasil dibagikan!'),
                              backgroundColor: Color(0xFF165540),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          // Navigasi kembali ke halaman utama
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFBBD3B1),
                          foregroundColor: const Color(0xFF165540),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Lingkaran Avatar Pengguna
                            Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  userAvatarUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                    Icons.person,
                                    size: 16,
                                    color: Color(0xFF165540),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'cerita anda',
                              style: GoogleFonts.poppins(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewImage(String path) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: const Color(0xFF2B3A2C),
          child: const Center(
            child: Icon(
              Icons.broken_image_rounded,
              size: 64,
              color: Colors.white54,
            ),
          ),
        ),
      );
    } else {
      return Image.file(
        File(path),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: const Color(0xFF2B3A2C),
          child: const Center(
            child: Icon(
              Icons.broken_image_rounded,
              size: 64,
              color: Colors.white54,
            ),
          ),
        ),
      );
    }
  }
}
