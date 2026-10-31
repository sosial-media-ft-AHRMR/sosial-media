import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/qcumber_colors.dart';

/// Laporan Diproses Modal Dialog / Sheet
/// Konversi presisi 99% dari Desain Figma "Laporan diproses.png" (402 x 306)
///
/// Fitur:
/// - Kartu hijau tua elegan (#165540) dengan sudut rounded
/// - Ikon centang pelaporan hijau segar
/// - Judul "Laporan Diproses"
/// - Deskripsi: "Terima kasih sudah melapor. Tim kami sedang memeriksa kendala ini dalam 1x24 jam ke depan"
/// - Tombol pill putih "Selesai" dengan teks warna #165540
class ReportProcessedDialog extends StatelessWidget {
  final VoidCallback? onDone;

  const ReportProcessedDialog({
    super.key,
    this.onDone,
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
          color: const Color(0xFF165540), // Warna solid sesuai Figma Laporan diproses.png
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ikon Centang Lingkaran Berhasil Melapor
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xFF82A86C).withValues(alpha: 0.25),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF82A86C),
                  width: 2.0,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.check_rounded,
                  color: Color(0xFFB5CBA9),
                  size: 34,
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Judul: Laporan Diproses
            Text(
              'Laporan Diproses',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),

            // Deskripsi Penjelasan
            Text(
              'Terima kasih sudah melapor. Tim kami sedang memeriksa kendala ini dalam 1x24 jam ke depan',
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.88),
                height: 1.45,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // Tombol "Selesai" (Pill Putih)
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (onDone != null) onDone!();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: QcumberColors.primaryGreen,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Text(
                  'Selesai',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: QcumberColors.primaryGreen,
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

/// Helper function untuk menampilkan ReportProcessedDialog
Future<void> showReportProcessedDialog(
  BuildContext context, {
  VoidCallback? onDone,
}) {
  return showDialog(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    builder: (context) => ReportProcessedDialog(onDone: onDone),
  );
}
