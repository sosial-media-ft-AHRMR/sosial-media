import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/qcumber_colors.dart';
import '../laporkan_masalah/laporkan_masalah_page.dart';
import 'akun_privat_page.dart';
import 'diblokir_page.dart';
import 'penggunaan_data_page.dart';
import 'privasi_keamanan_page.dart';
import 'status_aktivitas_page.dart';
import 'tempat_login_page.dart';
import 'verifikasi_dua_langkah_page.dart';

/// Halaman Pusat Bantuan Utama Qcumber
/// Menyediakan panduan, pencarian bantuan, dan akses langsung ke seluruh topik keamanan dan privasi
class PusatBantuanPage extends StatefulWidget {
  const PusatBantuanPage({super.key});

  @override
  State<PusatBantuanPage> createState() => _PusatBantuanPageState();
}

class _PusatBantuanPageState extends State<PusatBantuanPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
              // 1. Bilah Header: Tombol Kembali + Judul Pusat Bantuan
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 20.0,
                  top: 12.0,
                  bottom: 8.0,
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
                      'Pusat Bantuan',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: QcumberColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Kotak Pencarian Bantuan
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFFC7E39F),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val.toLowerCase();
                      });
                    },
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: QcumberColors.darkGreen,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Cari topik atau bantuan...',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 13,
                        color: QcumberColors.sageText.withValues(alpha: 0.7),
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: QcumberColors.primaryGreen,
                        size: 22,
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.close_rounded,
                                size: 18,
                                color: QcumberColors.sageText,
                              ),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _searchQuery = '');
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 6),

              // 3. Daftar Topik Bantuan (Scrollable)
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8.0,
                  ),
                  children: [
                    _buildSectionTitle('Topik Privasi & Keamanan'),
                    const SizedBox(height: 10),

                    _buildHelpCard(
                      icon: Icons.lock_outline_rounded,
                      title: 'Privasi dan Keamanan',
                      subtitle:
                          'Panduan keamanan akun, sandi, dan proteksi login',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const PrivasiKeamananHelpPage(),
                          ),
                        );
                      },
                    ),

                    _buildHelpCard(
                      icon: Icons.shield_outlined,
                      title: 'Verifikasi 2 Langkah',
                      subtitle:
                          'Amankan akun Qcumber dengan autentikasi ganda',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const VerifikasiDuaLangkahHelpPage(),
                          ),
                        );
                      },
                    ),

                    _buildHelpCard(
                      icon: Icons.visibility_off_outlined,
                      title: 'Akun Privat',
                      subtitle:
                          'Atur siapa saja yang dapat melihat postingan Anda',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AkunPrivatHelpPage(),
                          ),
                        );
                      },
                    ),

                    _buildHelpCard(
                      icon: Icons.devices_rounded,
                      title: 'Tempat Anda Login',
                      subtitle:
                          'Periksa perangkat dan riwayat sesi aktif akun',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TempatLoginHelpPage(),
                          ),
                        );
                      },
                    ),

                    _buildHelpCard(
                      icon: Icons.swap_vert_rounded,
                      title: 'Penggunaan Data',
                      subtitle:
                          'Hemat kuota dan atur kualitas unggahan foto/video',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const PenggunaanDataHelpPage(),
                          ),
                        );
                      },
                    ),

                    _buildHelpCard(
                      icon: Icons.sensors_rounded,
                      title: 'Status Aktivitas',
                      subtitle:
                          'Kontrol apakah pengguna lain melihat Anda online',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const StatusAktivitasHelpPage(),
                          ),
                        );
                      },
                    ),

                    _buildHelpCard(
                      icon: Icons.block_flipped,
                      title: 'Akun Diblokir',
                      subtitle: 'Kelola dan buka blokir pengguna tertentu',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DiblokirHelpPage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 16),
                    _buildSectionTitle('Butuh Bantuan Lebih Lanjut?'),
                    const SizedBox(height: 10),

                    _buildContactCard(
                      icon: Icons.error_outline_rounded,
                      title: 'Laporkan Masalah',
                      subtitle:
                          'Ada kendala atau bug di aplikasi? Beritahu tim Qcumber',
                      actionText: 'Kirim Laporan',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LaporkanMasalahPage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    _buildContactCard(
                      icon: Icons.support_agent_rounded,
                      title: 'Hubungi Tim Dukungan',
                      subtitle:
                          'Dapatkan respon cepat via email bantuan@qcumber.app',
                      actionText: 'Kirim Email',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Email bantuan disalin: support@qcumber.app',
                              style: GoogleFonts.poppins(fontSize: 13),
                            ),
                            backgroundColor: QcumberColors.primaryGreen,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: QcumberColors.primaryGreen,
      ),
    );
  }

  Widget _buildHelpCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    if (_searchQuery.isNotEmpty &&
        !title.toLowerCase().contains(_searchQuery) &&
        !subtitle.toLowerCase().contains(_searchQuery)) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        elevation: 0.5,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 14.0,
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F6EC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: QcumberColors.primaryGreen,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: QcumberColors.darkGreen,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: QcumberColors.sageText,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: QcumberColors.cucumberGreen,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String actionText,
    required VoidCallback onTap,
  }) {
    return Material(
      color: const Color(0xFFF0F6EC),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: QcumberColors.primaryGreen,
                size: 28,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: QcumberColors.primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: QcumberColors.sageText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      actionText,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: QcumberColors.primaryGreen,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

