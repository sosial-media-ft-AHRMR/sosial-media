import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/qcumber_colors.dart';

/// Share Bottom Sheet Qcumber
/// Konversi presisi 99% dari Desain Figma "Share.png" (402 x 226)
///
/// Fitur:
/// - Latar warna pale sage (#E9F1E4) dengan sudut rounded atas 24px
/// - Deretan avatar pengguna untuk kirim langsung (Rangga, Your.Idol, Shawn, dsb.)
/// - Tiga tombol aksi cepat:
///   1. "Tambahkan ke cerita"
///   2. "Salin Tautan"
///   3. "Bagikan"
class ShareBottomSheet extends StatelessWidget {
  final String? postUrl;
  final String? postAuthor;
  final VoidCallback? onAddToStory;
  final VoidCallback? onCopyLink;
  final VoidCallback? onShareExternal;

  const ShareBottomSheet({
    super.key,
    this.postUrl,
    this.postAuthor,
    this.onAddToStory,
    this.onCopyLink,
    this.onShareExternal,
  });

  @override
  Widget build(BuildContext context) {
    // Daftar kontak untuk kirim langsung sesuai desain Figma
    final contacts = [
      {'name': 'Rangga', 'avatar': 'assets/feed/story_rangga.png'},
      {'name': 'Your.Idol', 'avatar': 'assets/feed/avatar_your_idol.png'},
      {'name': 'Shawn', 'avatar': 'assets/feed/avatar_shawn.png'},
      {'name': 'MrShadow', 'avatar': 'assets/feed/avatar_mrshadow.png'},
      {'name': 'Peter', 'avatar': 'assets/feed/avatar_peter.png'},
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFE9F1E4), // Sesuai warna Figma Share.png
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle Bar
            Center(
              child: Container(
                width: 38,
                height: 4,
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF82A86C).withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // 1. Deretan Avatar Kontak (Kirim Langsung)
            SizedBox(
              height: 76,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: contacts.length,
                separatorBuilder: (context, index) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Postingan terkirim ke ${contact['name']}',
                            style: GoogleFonts.poppins(fontSize: 13),
                          ),
                          duration: const Duration(seconds: 1),
                          backgroundColor: QcumberColors.primaryGreen,
                        ),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: QcumberColors.cucumberGreen.withValues(alpha: 0.5),
                              width: 1.5,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              contact['avatar']!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                Icons.person,
                                color: QcumberColors.primaryGreen,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: 58,
                          child: Text(
                            contact['name']!,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: QcumberColors.primaryGreen,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),
            const Divider(color: Color(0xFFD0DFC9), height: 1),
            const SizedBox(height: 14),

            // 2. Tiga Tombol Aksi Bawah
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  context: context,
                  icon: Icons.add_circle_outline_rounded,
                  label: 'Tambahkan ke\ncerita',
                  onTap: () {
                    Navigator.pop(context);
                    if (onAddToStory != null) {
                      onAddToStory!();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Membagikan ke Cerita Anda',
                            style: GoogleFonts.poppins(fontSize: 13),
                          ),
                          duration: const Duration(seconds: 1),
                          backgroundColor: QcumberColors.primaryGreen,
                        ),
                      );
                    }
                  },
                ),
                _buildActionButton(
                  context: context,
                  icon: Icons.link_rounded,
                  label: 'Salin Tautan',
                  onTap: () {
                    Navigator.pop(context);
                    Clipboard.setData(ClipboardData(
                      text: postUrl ?? 'https://qcumber.app/post/share-preview',
                    ));
                    if (onCopyLink != null) {
                      onCopyLink!();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Tautan berhasil disalin ke papan klip',
                            style: GoogleFonts.poppins(fontSize: 13),
                          ),
                          duration: const Duration(seconds: 1),
                          backgroundColor: QcumberColors.primaryGreen,
                        ),
                      );
                    }
                  },
                ),
                _buildActionButton(
                  context: context,
                  icon: Icons.share_outlined,
                  label: 'Bagikan',
                  onTap: () {
                    Navigator.pop(context);
                    if (onShareExternal != null) {
                      onShareExternal!();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Membuka opsi bagikan perangkat',
                            style: GoogleFonts.poppins(fontSize: 13),
                          ),
                          duration: const Duration(seconds: 1),
                          backgroundColor: QcumberColors.primaryGreen,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 22,
              color: QcumberColors.primaryGreen,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
              color: QcumberColors.primaryGreen,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Helper function untuk memanggil ShareBottomSheet
Future<void> showShareBottomSheet(
  BuildContext context, {
  String? postUrl,
  String? postAuthor,
  VoidCallback? onAddToStory,
  VoidCallback? onCopyLink,
  VoidCallback? onShareExternal,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => ShareBottomSheet(
      postUrl: postUrl,
      postAuthor: postAuthor,
      onAddToStory: onAddToStory,
      onCopyLink: onCopyLink,
      onShareExternal: onShareExternal,
    ),
  );
}

