import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/post_item.dart';
import '../theme/qcumber_colors.dart';
import '../widgets/post_card.dart';

/// Halaman Bookmark / Postingan Disimpan Qcumber
/// Konversi presisi 99% dari Desain Figma "Disimpan.png" (402 x 1163)
///
/// Fitur:
/// - Bilah atas dengan tombol kembali (<)
/// - Judul "Bookmark" warna hijau tua (#165540)
/// - Kategori tab "Postingan"
/// - Daftar postingan yang tersimpan dengan kartu berlekuk (PostCard)
class DisimpanPage extends StatefulWidget {
  const DisimpanPage({super.key});

  @override
  State<DisimpanPage> createState() => _DisimpanPageState();
}

class _DisimpanPageState extends State<DisimpanPage> {
  // Daftar postingan tersimpan sesuai desain Figma Disimpan.png
  late List<PostItem> _savedPosts;

  @override
  void initState() {
    super.initState();
    _savedPosts = [
      PostItem(
        id: 'saved_1',
        username: 'Your.Idol',
        userAvatarUrl: 'assets/feed/avatar_your_idol.png',
        location: 'Bali, Indonesia',
        postImageUrl: 'assets/feed/post_bali.png',
        caption:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        timeAgo: '24 jam yang lalu',
        isVerified: true,
        likeCount: 231,
        isLiked: false,
        isSaved: true,
      ),
      PostItem(
        id: 'saved_2',
        username: 'Shawn',
        userAvatarUrl: 'assets/feed/avatar_shawn.png',
        location: 'New York, Amerika Serikat',
        postImageUrl: 'assets/feed/post_shawn.png',
        caption:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        timeAgo: '3 jam yang lalu',
        likeCount: 512,
        isLiked: false,
        isSaved: true,
      ),
      PostItem(
        id: 'saved_3',
        username: 'Alexumber',
        userAvatarUrl: 'assets/feed/alexumber_avatar.jpg',
        location: 'New York, Amerika Serikat',
        postImageUrl: 'assets/feed/alexumber_post1.jpg',
        caption:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        timeAgo: '2 minggu yang lalu',
        likeCount: 89,
        isLiked: false,
        isSaved: true,
      ),
    ];
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
              // 1. Bilah Header: Tombol Kembali + Judul Bookmark
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 20.0, top: 12.0, bottom: 8.0),
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
                      'Bookmark',
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: QcumberColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Kategori Tab: "Postingan"
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Postingan',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: QcumberColors.primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 76,
                      height: 3,
                      decoration: BoxDecoration(
                        color: QcumberColors.primaryGreen,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 4),

              // 3. Daftar Postingan Tersimpan
              Expanded(
                child: _savedPosts.isEmpty
                    ? Center(
                        child: Text(
                          'Belum ada postingan yang disimpan',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: QcumberColors.sageText,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 32.0),
                        physics: const BouncingScrollPhysics(),
                        itemCount: _savedPosts.length,
                        itemBuilder: (context, index) {
                          final post = _savedPosts[index];
                          return PostCard(
                            key: ValueKey(post.id),
                            post: post,
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

