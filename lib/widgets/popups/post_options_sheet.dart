import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/qcumber_colors.dart';
import 'report_processed_dialog.dart';

/// Post Options Bottom Sheet ("Humburger post.png")
/// Konversi presisi 99% dari Desain Figma "Humburger post.png" (402 x 158)
///
/// Pilihan:
/// 1. "Tidak tertarik" (Ikon visibility off / not interested)
/// 2. "Laporkan" (Ikon report flag/alert) -> Otomatis memicu dialog Laporan Diproses
class PostOptionsSheet extends StatelessWidget {
  final VoidCallback? onNotInterested;
  final VoidCallback? onReport;

  const PostOptionsSheet({
    super.key,
    this.onNotInterested,
    this.onReport,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFD6E2CF), // Latar presisi sesuai Figma Humburger post.png
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle Bar Atas
            Container(
              width: 38,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF82A86C).withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Pilihan 1: Tidak tertarik
            _buildOptionTile(
              context: context,
              icon: Icons.visibility_off_outlined,
              label: 'Tidak tertarik',
              onTap: () {
                Navigator.pop(context);
                if (onNotInterested != null) {
                  onNotInterested!();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Postingan disembunyikan dari beranda',
                        style: GoogleFonts.poppins(fontSize: 13),
                      ),
                      duration: const Duration(seconds: 1),
                      backgroundColor: QcumberColors.primaryGreen,
                    ),
                  );
                }
              },
            ),

            const SizedBox(height: 6),

            // Pilihan 2: Laporkan
            _buildOptionTile(
              context: context,
              icon: Icons.flag_outlined,
              label: 'Laporkan',
              onTap: () {
                Navigator.pop(context);
                if (onReport != null) {
                  onReport!();
                } else {
                  showReportProcessedDialog(context);
                }
              },
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        splashColor: QcumberColors.cucumberGreen.withValues(alpha: 0.15),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 22,
                color: QcumberColors.primaryGreen,
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                  color: QcumberColors.primaryGreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Helper function untuk menampilkan PostOptionsSheet dari mana saja
Future<void> showPostOptionsSheet(
  BuildContext context, {
  VoidCallback? onNotInterested,
  VoidCallback? onReport,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => PostOptionsSheet(
      onNotInterested: onNotInterested,
      onReport: onReport,
    ),
  );
}

