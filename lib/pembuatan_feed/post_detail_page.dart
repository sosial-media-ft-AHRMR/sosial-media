import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/post_item.dart';
import '../theme/qcumber_colors.dart';
import '../widgets/post_card.dart';

/// Halaman Rincian Postingan & Komentar
/// Sesuai 100% dengan Figma Rincian Post & Comment.png & No Comment.png
/// Menggunakan pemanggilan aset gambar lokal (Image.asset)
class PostDetailPage extends StatefulWidget {
  final PostItem post;

  const PostDetailPage({super.key, required this.post});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late List<Map<String, dynamic>> _comments;

  @override
  void initState() {
    super.initState();
    // Jika postingan ID post_1 atau post_3, memiliki data komentar sesuai Figma
    if (widget.post.id == 'post_1' || widget.post.id == 'post_3') {
      _comments = [
        {
          'id': 'c_1',
          'username': 'Your.Idol',
          'isVerified': true,
          'timeAgo': '15 Jam yang lalu',
          'text': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          'avatarUrl': 'assets/feed/avatar_your_idol.png',
          'isLiked': false,
          'replies': [
            {
              'id': 'r_1',
              'username': 'thv',
              'isVerified': true,
              'timeAgo': '14 Jam yang lalu',
              'text': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              'avatarUrl': 'assets/feed/avatar_thv.png',
              'isLiked': false,
            },
          ],
        },
      ];
    } else {
      // Postingan lain menampilkan kondisi "Belum ada komentar" sesuai No Comment.png
      _comments = [];
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addComment() {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _comments.add({
        'id': 'c_${DateTime.now().millisecondsSinceEpoch}',
        'username': 'Anda',
        'isVerified': true,
        'timeAgo': 'Baru saja',
        'text': text,
        'avatarUrl': 'assets/feed/avatar_thv.png',
        'isLiked': false,
        'replies': [],
      });
    });

    _commentController.clear();
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Komentar berhasil dikirim!'),
        backgroundColor: QcumberColors.primaryGreen,
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QcumberColors.white,
      body: Stack(
        children: [
          // 1. Efek Latar Radial Glow
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                color: QcumberColors.white,
                gradient: QcumberColors.backgroundGlow,
              ),
            ),
          ),

          // 2. Konten Utama (Header, Postingan, Utas Komentar)
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Header Rincian Post (Sesuai Rincian Post & Comment.png)
                _buildHeader(context),

                // Area Scroll Postingan & Komentar
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.only(bottom: 90),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Kartu Postingan Utama
                        PostCard(post: widget.post),

                        const SizedBox(height: 12),
                        const Divider(
                          color: Color(0xFFD4DDD6),
                          thickness: 1,
                          indent: 20,
                          endIndent: 20,
                        ),
                        const SizedBox(height: 14),

                        // Daftar Komentar atau Status "Belum ada komentar"
                        _comments.isEmpty
                            ? _buildEmptyCommentState()
                            : _buildCommentThreadList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. Floating Bottom Input Bar "Komentar" (Sesuai Figma)
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: SafeArea(top: false, child: _buildCommentInputBar()),
          ),
        ],
      ),
    );
  }

  /// Header halaman rincian dengan judul Qcumber dan tombol kembali
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(gradient: QcumberColors.headerGradient),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: QcumberColors.primaryGreen,
              size: 24,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            'Qcumber',
            style: GoogleFonts.poppins(
              fontSize: 34,
              fontWeight: FontWeight.w600,
              color: QcumberColors.primaryGreen,
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  /// Tampilan jika belum ada komentar (Sesuai No Comment.png)
  Widget _buildEmptyCommentState() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.center,
      child: Text(
        'Belum ada komentar',
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: QcumberColors.cucumberGreen,
        ),
      ),
    );
  }

  /// Daftar komentar berurutan dan balasan bersarang (Sesuai Rincian Post & Comment.png)
  Widget _buildCommentThreadList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _comments.map((comment) {
          final List replies = comment['replies'] as List? ?? [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Komentar Utama
              _buildCommentItem(comment, isReply: false),

              // Balasan Bersarang dengan Garis Pohon Kiri
              if (replies.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 36.0, top: 12.0),
                  child: Column(
                    children: replies.map((reply) {
                      return _buildCommentItem(
                        reply as Map<String, dynamic>,
                        isReply: true,
                      );
                    }).toList(),
                  ),
                ),
              ],
              const SizedBox(height: 18),
            ],
          );
        }).toList(),
      ),
    );
  }

  /// Komponen satu komentar
  Widget _buildCommentItem(Map<String, dynamic> item, {required bool isReply}) {
    final bool isLiked = item['isLiked'] as bool? ?? false;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar Bulat menggunakan Image.asset
        Container(
          width: isReply ? 30 : 36,
          height: isReply ? 30 : 36,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: ClipOval(
            child: Image.asset(item['avatarUrl'], fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 10),

        // Isi Komentar
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    item['username'],
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  if (item['isVerified'] == true) ...[
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.check_circle_rounded,
                      color: QcumberColors.cucumberGreen,
                      size: 14,
                    ),
                  ],
                  const SizedBox(width: 8),
                  Text(
                    item['timeAgo'],
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              Text(
                item['text'],
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: QcumberColors.sageText,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 6),

              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        item['isLiked'] = !isLiked;
                      });
                    },
                    child: Icon(
                      isLiked
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      size: 16,
                      color: isLiked
                          ? Colors.redAccent
                          : QcumberColors.sageText,
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      _commentController.text = '@${item['username']} ';
                    },
                    child: const Icon(
                      Icons.mode_comment_outlined,
                      size: 15,
                      color: QcumberColors.sageText,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Floating Comment Input Bar berbentuk kapsul abu-abu sesuai Figma
  Widget _buildCommentInputBar() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xFFD6DFD8),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          // Avatar Pengguna
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: ClipOval(
              child: Image.asset(
                'assets/feed/avatar_thv.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Field Tulis Komentar
          Expanded(
            child: TextField(
              controller: _commentController,
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
              decoration: InputDecoration(
                hintText: 'Komentar',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
              onSubmitted: (_) => _addComment(),
            ),
          ),

          // Tombol Galeri & Kirim
          IconButton(
            icon: const Icon(
              Icons.image_outlined,
              color: Colors.black54,
              size: 24,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Buka galeri untuk menambahkan gambar komentar',
                  ),
                  backgroundColor: QcumberColors.primaryGreen,
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.send_rounded,
              color: QcumberColors.primaryGreen,
              size: 22,
            ),
            onPressed: _addComment,
          ),
        ],
      ),
    );
  }
}
