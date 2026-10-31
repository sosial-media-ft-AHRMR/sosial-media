import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/qcumber_colors.dart';

/// Logout Confirmation Dialog / Bottom Sheet
/// Konversi presisi 99% dari Desain Figma "Log Out.png" (402 x 234)
///
/// Fitur:
/// - Latar pale sage (#E7EEE2) dengan sudut rounded atas 24px
/// - Pertanyaan: "Apakah anda yakin ingin keluar dari akun ini?"
/// - Tombol "Batal" (Border outlined rounded pill)
/// - Tombol "Keluar" (Solid green #165540 rounded pill dengan teks putih)
class LogoutConfirmationDialog extends StatelessWidget {
  final VoidCallback? onConfirmLogout;

  const LogoutConfirmationDialog({
    super.key,
    this.onConfirmLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFE7EEE2), // Warna latar presisi Figma Log Out.png
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle Bar Atas
            Container(
              width: 38,
              height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: const Color(0xFF82A86C).withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Teks Pertanyaan Konfirmasi
            Text(
              'Apakah anda yakin ingin keluar\ndari akun ini?',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: QcumberColors.primaryGreen,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 28),

            // Dua Tombol Aksi: Batal & Keluar
            Row(
              children: [
                // Tombol Batal
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: QcumberColors.primaryGreen,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(
                        'Batal',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: QcumberColors.primaryGreen,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Tombol Keluar
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        if (onConfirmLogout != null) {
                          onConfirmLogout!();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Berhasil keluar dari akun',
                                style: GoogleFonts.poppins(fontSize: 13),
                              ),
                              duration: const Duration(seconds: 1),
                              backgroundColor: QcumberColors.primaryGreen,
                            ),
                          );
                        }
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
                        'Keluar',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

/// Helper function untuk menampilkan Logout Confirmation Dialog/Sheet
Future<void> showLogoutConfirmationDialog(
  BuildContext context, {
  VoidCallback? onConfirmLogout,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => LogoutConfirmationDialog(
      onConfirmLogout: onConfirmLogout,
    ),
  );
}
