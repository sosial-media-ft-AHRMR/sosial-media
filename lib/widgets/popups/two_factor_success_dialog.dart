import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/qcumber_colors.dart';

/// Dialog Verifikasi Dua Langkah Berhasil
/// Konversi presisi 99% dari Desain Figma "Verif 2 langkah berhasil.png" (374 x 229)
///
/// Fitur:
/// - Kartu dialog rounded bersih dengan latar #F8FAF7
/// - Ikon perisai keamanan verifikasi dua langkah
/// - Teks: "Kata sandi verifikasi dua langkah anda berhasil dibuat" (#165540)
/// - Tombol rounded pill "Lanjut" (#165540 dengan teks putih)
class TwoFactorSuccessDialog extends StatelessWidget {
  final VoidCallback? onContinue;

  const TwoFactorSuccessDialog({
    super.key,
    this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 26.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAF7), // Warna latar presisi Figma Verif 2 langkah berhasil.png
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFFB5CBA9),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Ikon Keamanan / Perisai Terverifikasi
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFDEEBCE),
                border: Border.all(
                  color: QcumberColors.cucumberGreen,
                  width: 2.0,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.verified_user_rounded,
                  color: QcumberColors.primaryGreen,
                  size: 32,
                ),
              ),
            ),

            const SizedBox(height: 18),

            // 2. Pesan Keberhasilan Verifikasi
            Text(
              'Kata sandi verifikasi dua\nlangkah anda berhasil dibuat',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: QcumberColors.primaryGreen,
                height: 1.35,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 22),

            // 3. Tombol "Lanjut" (Pill Hijau Tua)
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (onContinue != null) onContinue!();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: QcumberColors.primaryGreen,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Text(
                  'Lanjut',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper function untuk menampilkan TwoFactorSuccessDialog
Future<void> showTwoFactorSuccessDialog(
  BuildContext context, {
  VoidCallback? onContinue,
}) {
  return showDialog(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.45),
    builder: (context) => TwoFactorSuccessDialog(onContinue: onContinue),
  );
}
