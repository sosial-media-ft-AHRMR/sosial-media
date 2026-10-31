import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/story_item.dart';
import '../theme/qcumber_colors.dart';

/// Widget bar horizontal untuk menampilkan Stories ("Slice")
/// Sesuai 99% dengan feed_preview.png:
/// - Kartu "Add a Slice" dengan border solid hijau tua (#165540) dan latar sage lembut (#DEEBCE)
/// - Kartu cerita pengguna berukuran 68x86 px dengan border gradien linear 180° (#165540 -> #C7E39F)
/// - Mendukung aset lokal maupun foto hasil tangkapan kamera/galeri perangkat
class SliceStoryBar extends StatelessWidget {
  final List<StoryItem> stories;
  final VoidCallback? onAddSlice;
  final ValueChanged<StoryItem>? onStoryTap;

  const SliceStoryBar({
    super.key,
    required this.stories,
    this.onAddSlice,
    this.onStoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 122,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: stories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final story = stories[index];
          return _buildStoryItem(context, story);
        },
      ),
    );
  }

  Widget _buildStoryItem(BuildContext context, StoryItem story) {
    return GestureDetector(
      onTap: () {
        if (story.isAddSlice) {
          onAddSlice?.call();
        } else {
          onStoryTap?.call(story);
        }
      },
      child: SizedBox(
        width: 68,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            story.isAddSlice
                ? _buildAddSliceCard()
                : _buildUserStoryCard(story),
            const SizedBox(height: 7),
            Text(
              story.username,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: QcumberColors.primaryGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Kartu "Add a Slice" sesuai 99% feed_preview.png
  Widget _buildAddSliceCard() {
    return Container(
      width: 68,
      height: 86,
      decoration: BoxDecoration(
        color: const Color(0xFFDEEBCE),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: QcumberColors.primaryGreen,
          width: 2.0,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.add_rounded,
          size: 34,
          color: QcumberColors.primaryGreen,
        ),
      ),
    );
  }

  /// Kartu cerita pengguna dengan border gradien linear 180° (#165540 -> #C7E39F)
  Widget _buildUserStoryCard(StoryItem story) {
    return Container(
      width: 68,
      height: 86,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: QcumberColors.storyBorderGradient,
      ),
      padding: const EdgeInsets.all(2.6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17),
        child: _buildStoryImage(story.imageUrl),
      ),
    );
  }

  Widget _buildStoryImage(String path) {
    if (path.isEmpty) {
      return Container(
        color: const Color(0xFFDEEBCE),
        child: const Icon(Icons.person, color: QcumberColors.primaryGreen),
      );
    }

    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: const Color(0xFFDEEBCE),
          child: const Icon(Icons.person, color: QcumberColors.primaryGreen),
        ),
      );
    } else {
      return Image.file(
        File(path),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: const Color(0xFFDEEBCE),
          child: const Icon(Icons.person, color: QcumberColors.primaryGreen),
        ),
      );
    }
  }
}
