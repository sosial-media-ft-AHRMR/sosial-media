import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/post_item.dart';
import '../theme/qcumber_colors.dart';

/// Clipper presisi 100% sesuai lekukan Figma Feed.png & feed_preview.png
/// Bagian bawah kiri dipotong dengan lekukan halus S-curve (lebar 168px, tinggi 44px)
/// sehingga 4 ikon interaksi duduk dengan sangat lapang dan presisi
class NotchedPhotoClipper extends CustomClipper<Path> {
  final double cornerRadius;
  final double notchWidth;
  final double notchHeight;
  final double transitionWidth;

  const NotchedPhotoClipper({
    this.cornerRadius = 22.0,
    this.notchWidth = 152.0,
    this.notchHeight = 37.0,
    this.transitionWidth = 47.0,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // 1. Sudut kiri atas melengkung
    path.moveTo(0, cornerRadius);
    path.quadraticBezierTo(0, 0, cornerRadius, 0);

    // 2. Garis atas lurus ke kanan
    path.lineTo(w - cornerRadius, 0);
    path.quadraticBezierTo(w, 0, w, cornerRadius);

    // 3. Garis kanan lurus ke bawah
    path.lineTo(w, h - cornerRadius);
    path.quadraticBezierTo(w, h, w - cornerRadius, h);

    // 4. Garis bawah sisi kanan ke titik awal transisi lengkungan
    final xStart = notchWidth + transitionWidth;
    path.lineTo(xStart, h);

    // 5. Lekukan S-curve mulus ("melengkung" sesuai Figma)
    final cOffset = transitionWidth * 0.45;
    path.cubicTo(
      xStart - cOffset,
      h,
      notchWidth + cOffset,
      h - notchHeight,
      notchWidth,
      h - notchHeight,
    );

    // 6. Garis horizontal ("lurus") di atas 4 ikon ke arah kiri
    path.lineTo(cornerRadius, h - notchHeight);

    // 7. Sudut kiri notch melengkung menyatu ke sisi kiri foto
    path.quadraticBezierTo(
      0,
      h - notchHeight,
      0,
      h - notchHeight - cornerRadius,
    );

    // 8. Menutup path ke titik awal
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

/// Widget kartu postingan Feed individual
/// Sesuai 99% dengan Figma feed_preview.png:
/// - Potongan foto NotchedPhotoClipper dengan 4 ikon interaksi di lekukan bawah kiri
/// - Waktu postingan warna #536947 dan teks caption dengan toggle "...more" #82A86C
/// - Mendukung foto aset lokal maupun file kamera/galeri pengguna
class PostCard extends StatefulWidget {
  final PostItem post;
  final VoidCallback? onCommentTap;
  final VoidCallback? onShareTap;
  final VoidCallback? onMenuTap;

  const PostCard({
    super.key,
    required this.post,
    this.onCommentTap,
    this.onShareTap,
    this.onMenuTap,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Gambar Postingan dengan Lekukan Notch Sesuai feed_preview.png
          SizedBox(
            width: double.infinity,
            height: 240,
            child: Stack(
              children: [
                // Gambar Utama yang dipotong menggunakan NotchedPhotoClipper
                Positioned.fill(
                  child: ClipPath(
                    clipper: const NotchedPhotoClipper(),
                    child: _buildPostImage(post.postImageUrl),
                  ),
                ),

                // Gradien Halus di bagian atas foto agar teks putih terbaca jelas
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 64,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.45),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Header Overlay: Avatar, Username, Badge Verified, Lokasi, Kebab Menu
                Positioned(
                  top: 12,
                  left: 14,
                  right: 14,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Avatar bulat 34x34
                      Container(
                        width: 34,
                        height: 34,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black26,
                        ),
                        child: ClipOval(
                          child: _buildAvatarImage(post.userAvatarUrl),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Username dan Lokasi
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Text(
                                  post.username,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    shadows: const [
                                      Shadow(
                                        offset: Offset(0, 1),
                                        blurRadius: 3,
                                        color: Colors.black54,
                                      ),
                                    ],
                                  ),
                                ),
                                if (post.isVerified) ...[
                                  const SizedBox(width: 5),
                                  Container(
                                    width: 14,
                                    height: 14,
                                    decoration: const BoxDecoration(
                                      color: QcumberColors.cucumberGreen,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.check,
                                        size: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            Text(
                              post.location,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withValues(alpha: 0.95),
                                shadows: const [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 3,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Menu Kebab (Titik 3 vertikal)
                      GestureDetector(
                        onTap: widget.onMenuTap,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: const Icon(
                            Icons.more_vert_rounded,
                            color: Colors.white,
                            size: 22,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 1),
                                blurRadius: 3,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // 2. Baris 4 Ikon Aksi (Like, Comment, Share, Bookmark) di Dalam Notch
                // Ditempatkan presisi di ruang potongan putih kiri bawah
                Positioned(
                  left: 13,
                  bottom: 5,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Like Icon (❤️)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            post.isLiked = !post.isLiked;
                            if (post.isLiked) {
                              post.likeCount++;
                            } else {
                              post.likeCount--;
                            }
                          });
                        },
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 150),
                          scale: post.isLiked ? 1.15 : 1.0,
                          child: Image.asset(
                            post.isLiked
                                ? 'assets/feed/icon_heart_red.png'
                                : 'assets/feed/icon_heart.png',
                            height: 25,
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Comment Icon (💬)
                      GestureDetector(
                        onTap: widget.onCommentTap,
                        child: Image.asset(
                          'assets/feed/icon_comment.png',
                          height: 25,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Share Icon (✈️)
                      GestureDetector(
                        onTap: widget.onShareTap,
                        child: Image.asset(
                          'assets/feed/icon_share.png',
                          height: 25,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Bookmark Icon (🔖)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            post.isSaved = !post.isSaved;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                post.isSaved
                                    ? 'Postingan disimpan'
                                    : 'Batal menyimpan',
                                style: GoogleFonts.poppins(fontSize: 13),
                              ),
                              duration: const Duration(seconds: 1),
                              backgroundColor: QcumberColors.primaryGreen,
                            ),
                          );
                        },
                        child: Image.asset(
                          post.isSaved
                              ? 'assets/feed/icon_bookmark_active.png'
                              : 'assets/feed/icon_bookmark.png',
                          height: 25,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // 3. Waktu Postingan (misal: "24 jam yang lalu") - Warna #536947
          Text(
            post.timeAgo,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: QcumberColors.sageText,
            ),
          ),

          const SizedBox(height: 4),

          // 4. Caption dengan teks warna #536947 dan toggle "...more" warna #82A86C
          _buildCaptionSection(post),
        ],
      ),
    );
  }

  Widget _buildPostImage(String path) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: const Color(0xFFE2E8F0),
          child: const Center(
            child: Icon(
              Icons.broken_image_rounded,
              size: 48,
              color: Colors.grey,
            ),
          ),
        ),
      );
    } else {
      return Image.file(
        File(path),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: const Color(0xFFE2E8F0),
          child: const Center(
            child: Icon(
              Icons.broken_image_rounded,
              size: 48,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }
  }

  Widget _buildAvatarImage(String path) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.account_circle, size: 34, color: Colors.white),
      );
    } else {
      return Image.file(
        File(path),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.account_circle, size: 34, color: Colors.white),
      );
    }
  }

  /// Caption postingan dengan toggle "...more"
  Widget _buildCaptionSection(PostItem post) {
    final String caption = post.caption;
    final bool canExpand = caption.length > 70;
    final String shortText = canExpand
        ? '${caption.substring(0, 68)}...'
        : caption;
    final String displayText = _isExpanded ? caption : shortText;

    return GestureDetector(
      onTap: canExpand
          ? () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            }
          : null,
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: QcumberColors.sageText,
            height: 1.35,
          ),
          children: [
            TextSpan(text: displayText),
            if (canExpand)
              TextSpan(
                text: _isExpanded ? '  sembunyikan' : ' ...more',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: QcumberColors.cucumberGreen,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
