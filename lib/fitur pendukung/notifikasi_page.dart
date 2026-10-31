import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/qcumber_colors.dart';

/// Model item notifikasi internal halaman Notifikasi
class _NotificationItemData {
  final String username;
  final String avatarUrl;
  final String actionText;
  final String timeAgo;
  final String? postThumbnailUrl;
  final bool isFollowAction;
  bool isFollowing;

  _NotificationItemData({
    required this.username,
    required this.avatarUrl,
    required this.actionText,
    required this.timeAgo,
    this.postThumbnailUrl,
    this.isFollowAction = false,
    this.isFollowing = false,
  });
}

/// Halaman Riwayat Notifikasi Qcumber
/// Konversi presisi 99% dari Desain Figma "Notifikasi.png" (402 x 1163)
///
/// Fitur:
/// - Bilah header dengan tombol kembali (<) dan judul "Notifikasi"
/// - Pengelompokan bagian waktu: "Hari ini", "Kemarin", "7 hari terakhir", "30 hari terakhir"
/// - Item notifikasi lengkap dengan avatar, pesan interaksi, timestamp, dan
///   thumbnail postingan atau tombol aksi "Ikuti" yang interaktif
class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  // Data notifikasi sesuai tampilan Figma Notifikasi.png
  final List<_NotificationItemData> _todayNotifications = [
    _NotificationItemData(
      username: 'Your.Idol',
      avatarUrl: 'assets/feed/avatar_your_idol.png',
      actionText: 'Menyukai postingan anda',
      timeAgo: '2 jam yang lalu',
      postThumbnailUrl: 'assets/feed/post_bali.png',
    ),
    _NotificationItemData(
      username: 'thv',
      avatarUrl: 'assets/feed/avatar_thv.png',
      actionText: 'Menambah postingan baru.',
      timeAgo: '23 jam yang lalu',
      postThumbnailUrl: 'assets/feed/post_thv.png',
    ),
  ];

  final List<_NotificationItemData> _yesterdayNotifications = [
    _NotificationItemData(
      username: 'Shawn',
      avatarUrl: 'assets/feed/avatar_shawn.png',
      actionText: 'Menambah postingan baru.',
      timeAgo: '1 hari yang lalu',
      postThumbnailUrl: 'assets/feed/post_shawn.png',
    ),
    _NotificationItemData(
      username: 'Shawn',
      avatarUrl: 'assets/feed/avatar_shawn.png',
      actionText: 'Menyukai postingan anda.',
      timeAgo: '1 hari yang lalu',
      postThumbnailUrl: 'assets/feed/post_peter.png',
    ),
    _NotificationItemData(
      username: 'mr.shadow',
      avatarUrl: 'assets/feed/avatar_mrshadow.png',
      actionText: 'Menyukai postingan anda.',
      timeAgo: '1 hari yang lalu',
      postThumbnailUrl: 'assets/feed/post_bali.png',
    ),
  ];

  final List<_NotificationItemData> _last7DaysNotifications = [
    _NotificationItemData(
      username: 'mr.shadow',
      avatarUrl: 'assets/feed/avatar_mrshadow.png',
      actionText: 'Menambah postingan baru.',
      timeAgo: '5 hari yang lalu',
      postThumbnailUrl: 'assets/feed/post_thv.png',
    ),
    _NotificationItemData(
      username: 'Peter',
      avatarUrl: 'assets/feed/avatar_peter.png',
      actionText: 'Mulai mengikuti anda.',
      timeAgo: '6 hari yang lalu',
      isFollowAction: true,
      isFollowing: false,
    ),
    _NotificationItemData(
      username: 'Rangga',
      avatarUrl: 'assets/feed/story_rangga.png',
      actionText: 'Mulai mengikuti anda.',
      timeAgo: '23 jam yang lalu',
      isFollowAction: true,
      isFollowing: false,
    ),
  ];

  final List<_NotificationItemData> _last30DaysNotifications = [
    _NotificationItemData(
      username: 'thv',
      avatarUrl: 'assets/feed/avatar_thv.png',
      actionText: 'Mulai mengikuti anda.',
      timeAgo: '25 hari yang lalu',
      isFollowAction: true,
      isFollowing: false,
    ),
    _NotificationItemData(
      username: 'Your.Idol',
      avatarUrl: 'assets/feed/avatar_your_idol.png',
      actionText: 'Mulai mengikuti anda.',
      timeAgo: '28 hari yang lalu',
      isFollowAction: true,
      isFollowing: false,
    ),
  ];

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
              // 1. Bilah Header: Tombol Kembali + Judul Notifikasi
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 20.0, top: 12.0, bottom: 12.0),
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
                      'Notifikasi',
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: QcumberColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Daftar Notifikasi Scrollable
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildSectionHeader('Hari ini'),
                    ..._todayNotifications.map(_buildNotificationTile),
                    const SizedBox(height: 16),

                    _buildSectionHeader('Kemarin'),
                    ..._yesterdayNotifications.map(_buildNotificationTile),
                    const SizedBox(height: 16),

                    _buildSectionHeader('7 hari terakhir'),
                    ..._last7DaysNotifications.map(_buildNotificationTile),
                    const SizedBox(height: 16),

                    _buildSectionHeader('30 hari terakhir'),
                    ..._last30DaysNotifications.map(_buildNotificationTile),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 12.0, top: 4.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: QcumberColors.primaryGreen,
        ),
      ),
    );
  }

  Widget _buildNotificationTile(_NotificationItemData item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Foto Avatar Bulat
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: QcumberColors.cucumberGreen.withValues(alpha: 0.5),
                width: 1.2,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                item.avatarUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.person,
                  color: QcumberColors.primaryGreen,
                  size: 26,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Teks Pesan Notifikasi & Timestamp
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: QcumberColors.sageText,
                      height: 1.3,
                    ),
                    children: [
                      TextSpan(
                        text: item.username,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: QcumberColors.primaryGreen,
                        ),
                      ),
                      TextSpan(text: ' ${item.actionText}'),
                    ],
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.timeAgo,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w400,
                    color: QcumberColors.sageText.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // Bagian Kanan: Thumbnail Post atau Tombol "Ikuti"
          if (item.postThumbnailUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                item.postThumbnailUrl!,
                width: 44,
                height: 44,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 44,
                  height: 44,
                  color: const Color(0xFFE2E8F0),
                  child: const Icon(Icons.image, size: 20, color: Colors.grey),
                ),
              ),
            )
          else if (item.isFollowAction)
            SizedBox(
              height: 32,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    item.isFollowing = !item.isFollowing;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: item.isFollowing
                      ? const Color(0xFFDEEBCE)
                      : QcumberColors.primaryGreen,
                  foregroundColor: item.isFollowing
                      ? QcumberColors.primaryGreen
                      : Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  item.isFollowing ? 'Mengikuti' : 'Ikuti',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

