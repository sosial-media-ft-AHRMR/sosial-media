import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/qcumber_colors.dart';
import '../widgets/popups/report_processed_dialog.dart';

/// Halaman Laporkan Masalah Qcumber
/// Konversi presisi 99% dari Figma `figma/laporan masalah/Laporkan Masalah.png` (402 x 1075)
///
/// Fitur:
/// 1. Top bar: Tombol back '<' + Judul "Laporkan Masalah" dengan latar gradasi hijau khas Qcumber
/// 2. Seksi "Pilih Kategori":
///    - Opsi Macet, Gagal Upload, Chat & Notif, Akun/Login dengan custom radio button #165540
///    - Opsi "Lainnya" dengan input textfield rounded border #165540 dan latar #E9F1E4
/// 3. Seksi "Detail Kendala":
///    - Kotak textarea multiline dengan latar #E9F1E4 dan border #165540
///    - Hint text: "Ceritakan kendala apa yang kamu alami"
/// 4. Kartu "Sertakan Log Sistem":
///    - Latar #E9F1E4, border halus & bayangan lembut
///    - Deskripsi: "Kirim info teknis perangkat otomatis agar tim lebih cepat melacak bug"
///    - Toggle switch interaktif (aktif secara default sesuai Figma)
/// 5. Tombol Stadium "Kirim Laporan":
///    - Warna #165540 dengan teks putih tebal
///    - Menampilkan dialog pop-up konfirmasi `ReportProcessedDialog`
class LaporkanMasalahPage extends StatefulWidget {
  const LaporkanMasalahPage({super.key});

  @override
  State<LaporkanMasalahPage> createState() => _LaporkanMasalahPageState();
}

class _LaporkanMasalahPageState extends State<LaporkanMasalahPage> {
  // Kategori yang dipilih (default 'Lainnya' sesuai Figma Laporkan Masalah-1.png)
  String? _selectedCategory = 'Lainnya';

  // Controller untuk input teks Lainnya dan Detail Kendala
  final TextEditingController _lainnyaController =
      TextEditingController(text: 'Bug');
  final TextEditingController _detailController = TextEditingController();

  // Switch Sertakan Log Sistem (default true sesuai Figma)
  bool _includeSystemLogs = true;

  // Daftar opsi kategori utama
  static const List<String> _categories = [
    'Macet',
    'Gagal Upload',
    'Chat & Notif',
    'Akun/Login',
  ];

  @override
  void dispose() {
    _lainnyaController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  void _submitReport() {
    // Tampilkan dialog laporan diproses sesuai Figma Laporan diproses.png
    showReportProcessedDialog(
      context,
      onDone: () {
        if (mounted) {
          Navigator.of(context).maybePop();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFCFDEC7),
              Color(0xFFF2F7EF),
              Colors.white,
            ],
            stops: [0.0, 0.18, 0.40],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 1. Header Top Bar
              _buildTopBar(),

              // 2. Isi Formulir Laporan Masalah (Scrollable)
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 18),

                      // ==========================================
                      // SEKSI 1: PILIH KATEGORI
                      // ==========================================
                      Text(
                        'Pilih Kategori',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: QcumberColors.primaryGreen,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Daftar 4 Kategori Utama dengan Radio Button
                      for (final category in _categories) ...[
                        _buildCategoryRadioItem(category),
                        const Divider(
                          height: 22,
                          thickness: 1,
                          color: Color(0xFFC7D5C2),
                        ),
                      ],

                      // Opsi "Lainnya"
                      const SizedBox(height: 2),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _selectedCategory = 'Lainnya';
                          });
                        },
                        child: Text(
                          'Lainnya',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: QcumberColors.primaryGreen,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Input Box untuk Kategori Lainnya (lebar proporsional sesuai Figma)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 256,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE9F1E4),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: QcumberColors.primaryGreen,
                              width: 1.2,
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextField(
                            controller: _lainnyaController,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: QcumberColors.primaryGreen,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Tulis kendala yang kamu alami..',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF7D9B71),
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onTap: () {
                              setState(() {
                                _selectedCategory = 'Lainnya';
                              });
                            },
                            onChanged: (value) {
                              if (_selectedCategory != 'Lainnya') {
                                setState(() {
                                  _selectedCategory = 'Lainnya';
                                });
                              }
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 26),

                      // ==========================================
                      // SEKSI 2: DETAIL KENDALA
                      // ==========================================
                      Text(
                        'Detail Kendala',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: QcumberColors.primaryGreen,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Kotak Text Area Detail Kendala
                      Container(
                        width: double.infinity,
                        height: 130,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9F1E4),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: QcumberColors.primaryGreen,
                            width: 1.2,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        child: TextField(
                          controller: _detailController,
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          style: GoogleFonts.poppins(
                            fontSize: 13.5,
                            color: QcumberColors.primaryGreen,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Ceritakan kendala apa yang kamu alami',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 13,
                              color: const Color(0xFF7D9B71),
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ==========================================
                      // SEKSI 3: SERTAKAN LOG SISTEM CARD
                      // ==========================================
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9F1E4),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sertakan Log Sistem',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w700,
                                      color: QcumberColors.primaryGreen,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    'Kirim info teknis perangkat otomatis agar tim lebih cepat melacak bug',
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF4A6B53),
                                      height: 1.35,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Custom Pill Switch Sesuai Figma
                            _buildCustomSwitch(
                              value: _includeSystemLogs,
                              onChanged: (val) {
                                setState(() {
                                  _includeSystemLogs = val;
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 36),

                      // ==========================================
                      // SEKSI 4: TOMBOL KIRIM LAPORAN
                      // ==========================================
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: ElevatedButton(
                              onPressed: _submitReport,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: QcumberColors.primaryGreen,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: const StadiumBorder(),
                              ),
                              child: Text(
                                'Kirim Laporan',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Top Bar Header dengan Tombol Kembali dan Judul Halaman
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.maybePop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: QcumberColors.primaryGreen,
              size: 22,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 14),
          Text(
            'Laporkan Masalah',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: QcumberColors.primaryGreen,
            ),
          ),
        ],
      ),
    );
  }

  /// Item Radio Kategori dengan Lingkaran Custom Hijau #165540
  Widget _buildCategoryRadioItem(String category) {
    final bool isSelected = _selectedCategory == category;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      splashColor: QcumberColors.cucumberGreen.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Text(
              category,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: QcumberColors.primaryGreen,
              ),
            ),
            const Spacer(),
            // Radio circle border #165540
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: QcumberColors.primaryGreen,
                  width: 2.2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 11,
                        height: 11,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: QcumberColors.primaryGreen,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  /// Custom Pill Switch Toggle sesuai desain Figma (Track #165540 + Thumb Putih)
  Widget _buildCustomSwitch({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 44,
        height: 24,
        padding: const EdgeInsets.all(2.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: value ? QcumberColors.primaryGreen : const Color(0xFFC7D5C2),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 19,
            height: 19,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

