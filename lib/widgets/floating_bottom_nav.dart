import 'package:flutter/material.dart';

import '../theme/qcumber_colors.dart';

/// Floating Bottom Navigation Bar dengan 5 tab
/// Menggunakan pemanggilan aset ikon asli dari Figma
class FloatingBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const FloatingBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 18, right: 18, bottom: 20),
      height: 64,
      decoration: BoxDecoration(
        color: QcumberColors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: const Color(0xFFDEEBCE).withValues(alpha: 0.7),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 18,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 0. Home Icon
          _buildNavAssetItem(
            index: 0,
            assetPath: 'assets/feed/icon_nav_home.png',
          ),

          // 1. Search Icon
          _buildNavAssetItem(
            index: 1,
            assetPath: 'assets/feed/icon_nav_search.png',
          ),

          // 2. Add Button Utama (Kotak rounded gradien hijau dengan plus putih)
          _buildCenterAddButton(),

          // 3. Chat Icon
          _buildNavAssetItem(
            index: 3,
            assetPath: 'assets/feed/icon_nav_chat.png',
          ),

          // 4. Profile Icon
          _buildNavAssetItem(
            index: 4,
            assetPath: 'assets/feed/icon_nav_profile.png',
          ),
        ],
      ),
    );
  }

  Widget _buildNavAssetItem({required int index, required String assetPath}) {
    final bool isActive = currentIndex == index;

    return InkWell(
      onTap: () => onTabSelected(index),
      borderRadius: BorderRadius.circular(30),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: isActive ? 1.0 : 0.70,
          child: Image.asset(
            assetPath,
            width: 28,
            height: 28,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  /// Tombol Tambah Tengah dengan gradien hijau dan radius 16 sesuai Feed.png
  Widget _buildCenterAddButton() {
    return GestureDetector(
      onTap: () => onTabSelected(2),
      child: Container(
        width: 64,
        height: 42,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF79A26B), Color(0xFF2B7561)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2B7561).withValues(alpha: 0.35),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Center(
          child: Icon(Icons.add_rounded, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}
