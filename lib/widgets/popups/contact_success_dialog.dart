import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/qcumber_colors.dart';

/// Dialog Berhasil Tambah Info Kontak
/// Konversi presisi 99% dari Desain Figma "Berhasil tambah info kontak.png" (402 x 307)
///
/// Fitur:
/// - Kartu dialog rounded bersih dengan latar pale sage (#DEEBCE / #F4F8F1)
/// - Ikon centang hijau sukses berukuran besar di bagian tengah
/// - Teks: "Berhasil menambahkan info kontak baru" (#165540)
/// - Tombol rounded pill "Selanjutnya" (#165540 dengan teks putih)
class ContactSuccessDialog extends StatelessWidget {
  final VoidCallback? onNext;

  const ContactSuccessDialog({
    super.key,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F8F1), // Latar bersih sesuai desain Qcumber
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
            // 1. Ikon Centang Sukses Lingkaran
            Container(
              width: 64,
              height: 64,
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
                  Icons.check_rounded,
                  color: QcumberColors.primaryGreen,
                  size: 38,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 2. Teks Pesan Keberhasilan
            Text(
              'Berhasil menambahkan info\nkontak baru',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: QcumberColors.primaryGreen,
                height: 1.35,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // 3. Tombol "Selanjutnya" (Pill Hijau Tua)
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (onNext != null) onNext!();
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
                  'Selanjutnya',
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

/// Helper function untuk menampilkan ContactSuccessDialog
Future<void> showContactSuccessDialog(
  BuildContext context, {
  VoidCallback? onNext,
}) {
  return showDialog(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.45),
    builder: (context) => ContactSuccessDialog(onNext: onNext),
  );
}
