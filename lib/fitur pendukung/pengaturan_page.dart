import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../informasi_pribadi/informasi_pribadi_page.dart';
import '../laporkan_masalah/laporkan_masalah_page.dart';
import '../pengaturan/pengaturan.dart';
import '../pusat bantuan/pusat_bantuan_page.dart';
import '../theme/qcumber_colors.dart';
import '../widgets/popups/logout_dialog.dart';
import '../widgets/popups/switch_account_sheet.dart';

/// Halaman Pengaturan Qcumber
/// Konversi presisi 99% dari Desain Figma "Pengaturan.png" (Gambar Kedua)
///
/// Fitur:
/// - Bilah header: Tombol kembali (<) dan judul "Pengaturan" (#165540)
/// - Seksi 1: Akun (Informasi Pribadi, Privasi dan Keamanan, Pengunaan Data)
/// - Garis pembatas tebal abu-abu (#BEBEBE)
/// - Seksi 2: Privasi (Akun Privat, Status Aktivitas, Diblokir)
/// - Garis pembatas tebal abu-abu (#BEBEBE)
/// - Seksi 3: Bantuan dan Info (Pusat Bantuan, Laporkan Masalah)
/// - Garis pembatas tebal abu-abu (#BEBEBE)
/// - Seksi 4: Aksi Akun (Kartu profil Alexumber dengan border rounded, dan tombol Keluar)
class PengaturanPage extends StatefulWidget {
  const PengaturanPage({super.key});

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFCFDEC7), Color(0xFFF7FAF5), Colors.white],
            stops: [0.0, 0.18, 0.45],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Bilah Atas: Tombol Kembali (<) + Judul "Pengaturan"
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 20.0,
                  top: 12.0,
                  bottom: 12.0,
                ),
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
                      'Pengaturan',
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: QcumberColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Konten Pengaturan Scrollable
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // ==========================================
                    // SEKSI 1: AKUN
                    // ==========================================
                    _buildSectionHeader('Akun'),
                    _buildSettingsItem(
                      icon: Icons.person_outline_rounded,
                      title: 'Informasi Pribadi',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InformasiPribadiPage(),
                          ),
                        );
                      },
                    ),
                    _buildThinDivider(),
                    _buildSettingsItem(
                      icon: Icons.lock_outline_rounded,
                      title: 'Privasi dan Keamanan',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivasiKeamananPage(),
                          ),
                        );
                      },
                    ),
                    _buildThinDivider(),
                    _buildSettingsItem(
                      icon: Icons.swap_vert_rounded,
                      title: 'Pengunaan Data',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PenggunaanDataPage(),
                          ),
                        );
                      },
                    ),

                    // Pembatas Tebal Antar Bagian (#BEBEBE)
                    _buildThickSectionDivider(),

                    // ==========================================
                    // SEKSI 2: PRIVASI
                    // ==========================================
                    _buildSectionHeader('Privasi'),
                    _buildSettingsItem(
                      customIcon: _buildPrivateAccountIcon(
                        QcumberColors.primaryGreen,
                      ),
                      title: 'Akun Privat',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AkunPrivatPage(),
                          ),
                        );
                      },
                    ),
                    _buildThinDivider(),
                    _buildSettingsItem(
                      customIcon: _buildActivityStatusIcon(
                        QcumberColors.primaryGreen,
                      ),
                      title: 'Status Aktivitas',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StatusAktivitasPage(),
                          ),
                        );
                      },
                    ),
                    _buildThinDivider(),
                    _buildSettingsItem(
                      icon: Icons.block_flipped,
                      title: 'Diblokir',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DiblokirPage(),
                          ),
                        );
                      },
                    ),

                    // Pembatas Tebal Antar Bagian (#BEBEBE)
                    _buildThickSectionDivider(),

                    // ==========================================
                    // SEKSI 3: BANTUAN DAN INFO
                    // ==========================================
                    _buildSectionHeader('Bantuan dan Info'),
                    _buildSettingsItem(
                      icon: Icons.headset_mic_outlined,
                      title: 'Pusat Bantuan',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PusatBantuanPage(),
                          ),
                        );
                      },
                    ),
                    _buildThinDivider(),
                    _buildSettingsItem(
                      icon: Icons.error_outline_rounded,
                      title: 'Laporkan Masalah',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LaporkanMasalahPage(),
                          ),
                        );
                      },
                    ),

                    // Pembatas Tebal Antar Bagian (#BEBEBE)
                    _buildThickSectionDivider(),

                    // ==========================================
                    // SEKSI 4: AKSI AKUN
                    // ==========================================
                    _buildSectionHeader('Aksi Akun'),

                    // Kartu Profil Alexumber dengan Border Rounded
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                        vertical: 8.0,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () => showSwitchAccountSheet(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFF82A86C)
                                    .withValues(alpha: 0.5),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: QcumberColors.cucumberGreen,
                                      width: 1.2,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/feed/alexumber_avatar.jpg',
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                                Icons.person,
                                                color:
                                                    QcumberColors.primaryGreen,
                                              ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    'Alexumber',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: QcumberColors.primaryGreen,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 16,
                                  color: QcumberColors.primaryGreen,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Tombol Keluar (Sesuai Figma: warna #165540)
                    _buildSettingsItem(
                      icon: Icons.logout_rounded,
                      title: 'Keluar',
                      showChevron: false,
                      onTap: () => showLogoutConfirmationDialog(context),
                    ),

                    const SizedBox(height: 36),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Judul Seksi (Akun, Privasi, Bantuan dan Info, Aksi Akun)
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 16.0,
        bottom: 8.0,
      ),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: QcumberColors.primaryGreen,
        ),
      ),
    );
  }

  /// Item Pengaturan (Ikon + Teks + Panah >)
  Widget _buildSettingsItem({
    IconData? icon,
    Widget? customIcon,
    required String title,
    required VoidCallback onTap,
    Color? titleColor,
    Color? iconColor,
    bool showChevron = true,
  }) {
    final tColor = titleColor ?? QcumberColors.primaryGreen;
    final iColor = iconColor ?? QcumberColors.primaryGreen;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: QcumberColors.cucumberGreen.withValues(alpha: 0.15),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
          child: Row(
            children: [
              customIcon ?? Icon(icon, size: 24, color: iColor),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                    color: tColor,
                  ),
                ),
              ),
              if (showChevron)
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                  color: QcumberColors.primaryGreen,
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Ikon Akun Privat (Person outline dengan gembok kecil di sudut kanan bawah)
  Widget _buildPrivateAccountIcon(Color color) {
    return SizedBox(
      width: 24,
      height: 24,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Icon(Icons.person_outline_rounded, size: 22, color: color),
          ),
          Positioned(
            right: -2,
            bottom: -1,
            child: Icon(Icons.lock_outline_rounded, size: 12, color: color),
          ),
        ],
      ),
    );
  }

  /// Ikon Status Aktivitas (Person outline dengan indikator bulatan di sudut kanan bawah)
  Widget _buildActivityStatusIcon(Color color) {
    return SizedBox(
      width: 24,
      height: 24,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Icon(Icons.person_outline_rounded, size: 22, color: color),
          ),
          Positioned(
            right: 1,
            bottom: 2,
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }

  /// Garis pembatas tipis (#D0DFC9) antar item dalam satu seksi
  Widget _buildThinDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Divider(height: 1, thickness: 1, color: Color(0xFFD0DFC9)),
    );
  }

  /// Garis pembatas tebal abu-abu (#BEBEBE) antar seksi
  Widget _buildThickSectionDivider() {
    return Container(
      width: double.infinity,
      height: 7,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      color: const Color(0xFFBEBEBE),
    );
  }
}
