import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/qcumber_colors.dart';

/// Widget Header Qcumber Sesuai 99% dengan Figma feed_preview.png
/// - Ikon menu drawer: 3 garis horizontal hijau tua (#165540) presisi
/// - Judul besar "Qcumber" (bold 38px, #165540) di tengah
/// - Slogan "A fresh slice of life" (16px, #165540) tepat di bawah judul
/// - Gradasi halus dari kiri putih ke kanan hijau sage (#AED09B)
class FeedHeader extends StatelessWidget {
  final VoidCallback? onMenuPressed;

  const FeedHeader({
    super.key,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.0, 0.95],
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFAED09B),
          ],
        ),
      ),
      padding: const EdgeInsets.only(
        top: 6.0,
        bottom: 12.0,
        left: 20.0,
        right: 20.0,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 1. Ikon Hamburger Menu Menggunakan Aset Asli (assets/feed/icon_menu.png)
          Positioned(
            left: 0,
            child: GestureDetector(
              onTap: onMenuPressed,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 4.0, vertical: 8.0),
                child: Image.asset(
                  'assets/feed/icon_menu.png',
                  width: 28,
                  height: 28,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 28,
                        height: 2.8,
                        decoration: BoxDecoration(
                          color: QcumberColors.primaryGreen,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 5.5),
                      Container(
                        width: 28,
                        height: 2.8,
                        decoration: BoxDecoration(
                          color: QcumberColors.primaryGreen,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 5.5),
                      Container(
                        width: 28,
                        height: 2.8,
                        decoration: BoxDecoration(
                          color: QcumberColors.primaryGreen,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 2. Judul Brand dan Slogan di Tengah (Presisi Sesuai feed_preview.png)
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Qcumber',
                style: GoogleFonts.poppins(
                  fontSize: 38,
                  fontWeight: FontWeight.w700,
                  color: QcumberColors.primaryGreen,
                  letterSpacing: -0.5,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'A fresh slice of life',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: QcumberColors.primaryGreen,
                  letterSpacing: 0.1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
