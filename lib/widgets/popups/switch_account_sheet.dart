import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/qcumber_colors.dart';

/// Switch Account Bottom Sheet ("Beralih akun.png")
/// Konversi presisi 99% dari Desain Figma "Beralih akun.png" (402 x 191)
///
/// Fitur:
/// - Latar pale sage (#ECF2E9) dengan sudut rounded atas 24px
/// - Akun aktif: Foto avatar, username 'Alexumber', dan tanda centang aktif hijau
/// - Pilihan "+ Tambahkan akun" dengan ikon plus di dalam lingkaran
class SwitchAccountSheet extends StatelessWidget {
  final String activeUsername;
  final String activeAvatarUrl;
  final VoidCallback? onAddAccount;
  final ValueChanged<String>? onSelectAccount;

  const SwitchAccountSheet({
    super.key,
    this.activeUsername = 'Alexumber',
    this.activeAvatarUrl = 'assets/feed/alexumber_avatar.jpg',
    this.onAddAccount,
    this.onSelectAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFECF2E9), // Warna presisi Figma Beralih akun.png
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

            // 1. Akun Saat Ini (Aktif)
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {
                  Navigator.pop(context);
                  if (onSelectAccount != null) {
                    onSelectAccount!(activeUsername);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: QcumberColors.cucumberGreen,
                            width: 1.5,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            activeAvatarUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.person,
                              color: QcumberColors.primaryGreen,
                              size: 26,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          activeUsername,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: QcumberColors.primaryGreen,
                          ),
                        ),
                      ),
                      // Ikon Centang Aktif
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: QcumberColors.primaryGreen,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.check_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 6),

            // 2. Tombol Tambahkan Akun
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {
                  Navigator.pop(context);
                  if (onAddAccount != null) {
                    onAddAccount!();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Membuka form tambah akun baru',
                          style: GoogleFonts.poppins(fontSize: 13),
                        ),
                        duration: const Duration(seconds: 1),
                        backgroundColor: QcumberColors.primaryGreen,
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFD6E2CF),
                          border: Border.all(
                            color: QcumberColors.cucumberGreen.withValues(alpha: 0.4),
                            width: 1.2,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add_rounded,
                            color: QcumberColors.primaryGreen,
                            size: 26,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        'Tambahkan akun',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: QcumberColors.primaryGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

/// Helper function untuk menampilkan SwitchAccountSheet
Future<void> showSwitchAccountSheet(
  BuildContext context, {
  String activeUsername = 'Alexumber',
  String activeAvatarUrl = 'assets/feed/alexumber_avatar.jpg',
  VoidCallback? onAddAccount,
  ValueChanged<String>? onSelectAccount,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => SwitchAccountSheet(
      activeUsername: activeUsername,
      activeAvatarUrl: activeAvatarUrl,
      onAddAccount: onAddAccount,
      onSelectAccount: onSelectAccount,
    ),
  );
}

