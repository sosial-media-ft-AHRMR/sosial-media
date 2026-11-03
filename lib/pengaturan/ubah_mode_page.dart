import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../mode_gelap_terang/theme_controller.dart';
import '../theme/qcumber_colors.dart';

/// Halaman Ubah Mode (Mode Gelap dan Terang)
/// Fitur kustomisasi tampilan berbasis token figma "mode gelap terang":
/// - Mode Terang: #C1E4B0 -> #E9F5E2 -> #FFFFFF
/// - Mode Gelap: #81A66B -> #536744 -> #25281E
class UbahModePage extends StatefulWidget {
  const UbahModePage({super.key});

  @override
  State<UbahModePage> createState() => _UbahModePageState();
}

class _UbahModePageState extends State<UbahModePage> {
  final ThemeController _themeController = ThemeController.instance;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _themeController,
      builder: (context, _) {
        final isDark = _themeController.isDarkMode;

        return Scaffold(
          backgroundColor: isDark ? const Color(0xFF1E2319) : Colors.white,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: _themeController.settingsGradient,
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Bilah Header: Tombol Kembali (<) + Judul "Ubah Mode"
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 16.0,
                      bottom: 20.0,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: _themeController.primaryTextColor,
                            size: 22,
                          ),
                          onPressed: () => Navigator.pop(context),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(width: 14),
                        Text(
                          'Ubah Mode',
                          style: GoogleFonts.poppins(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: _themeController.primaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 2. Konten Pilihan Mode
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        // Deskripsi Singkat
                        Text(
                          'Pilih tampilan tema yang paling nyaman untuk penggunaan Anda. Perubahan akan langsung diterapkan ke seluruh aplikasi.',
                          style: GoogleFonts.poppins(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w400,
                            color: _themeController.secondaryTextColor,
                            height: 1.45,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Kartu Mode Terang
                        _buildModeCard(
                          title: 'Mode Terang',
                          subtitle: 'Tampilan segar khas Qcumber dengan gradien hijau sage lembut',
                          isSelected: !isDark,
                          gradient: QcumberColors.lightModeGradient,
                          previewAsset: 'assets/images/mode_terang.png',
                          icon: Icons.light_mode_rounded,
                          accentColor: const Color(0xFF2C7769),
                          onTap: () => _themeController.setDarkMode(false),
                        ),

                        const SizedBox(height: 16),

                        // Kartu Mode Gelap
                        _buildModeCard(
                          title: 'Mode Gelap',
                          subtitle: 'Tampilan gelap elegan yang nyaman di mata pada malam hari & hemat daya',
                          isSelected: isDark,
                          gradient: QcumberColors.darkModeGradient,
                          previewAsset: 'assets/images/mode_gelap.png',
                          icon: Icons.dark_mode_rounded,
                          accentColor: const Color(0xFF81A66B),
                          onTap: () => _themeController.setDarkMode(true),
                        ),

                        const SizedBox(height: 28),

                        // Baris Toggle Cepat
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18.0,
                            vertical: 14.0,
                          ),
                          decoration: BoxDecoration(
                            color: _themeController.cardBackgroundColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFF536744)
                                  : const Color(0xFFD0DFC9),
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    isDark
                                        ? Icons.nightlight_round
                                        : Icons.wb_sunny_outlined,
                                    color: _themeController.primaryTextColor,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Aktifkan Mode Gelap',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: _themeController.primaryTextColor,
                                    ),
                                  ),
                                ],
                              ),
                              _buildCustomSwitch(
                                value: isDark,
                                onChanged: (val) =>
                                    _themeController.setDarkMode(val),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 28),

                        // Section Pratinjau Langsung (Live Preview)
                        Text(
                          'Pratinjau Tampilan',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: _themeController.primaryTextColor,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Box Preview Komponen
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: _themeController.pageGradient,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFF81A66B).withValues(alpha: 0.6)
                                  : const Color(0xFF82A86C).withValues(alpha: 0.4),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.08),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isDark
                                          ? const Color(0xFF81A66B)
                                          : QcumberColors.primaryGreen,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Q',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Qcumber Media',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: _themeController.primaryTextColor,
                                        ),
                                      ),
                                      Text(
                                        isDark ? 'Mode Gelap Aktif' : 'Mode Terang Aktif',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11,
                                          color: _themeController.secondaryTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Ini adalah contoh bagaimana teks dan komponen UI beradaptasi dengan mulus pada tema yang Anda pilih.',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: _themeController.primaryTextColor,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Kartu visual pilihan Mode Terang atau Gelap
  Widget _buildModeCard({
    required String title,
    required String subtitle,
    required bool isSelected,
    required LinearGradient gradient,
    required String previewAsset,
    required IconData icon,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    final isDark = _themeController.isDarkMode;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: _themeController.cardBackgroundColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected
                  ? QcumberColors.primaryGreen
                  : (isDark ? const Color(0xFF455839) : const Color(0xFFD0DFC9)),
              width: isSelected ? 2.2 : 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? QcumberColors.primaryGreen.withValues(alpha: isDark ? 0.35 : 0.15)
                    : Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                blurRadius: isSelected ? 12 : 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              // Preview gradient mini
              Container(
                width: 60,
                height: 72,
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.black.withValues(alpha: 0.15),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: title == 'Mode Gelap' ? Colors.white : const Color(0xFF165540),
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Teks Penjelasan
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: _themeController.primaryTextColor,
                          ),
                        ),
                        if (isSelected) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: QcumberColors.primaryGreen,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Aktif',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        color: _themeController.secondaryTextColor,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // Indikator Radio
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? QcumberColors.primaryGreen
                        : const Color(0xFF82A86C),
                    width: 2,
                  ),
                  color: isSelected ? QcumberColors.primaryGreen : Colors.transparent,
                ),
                child: isSelected
                    ? const Center(
                        child: Icon(
                          Icons.check,
                          size: 15,
                          color: Colors.white,
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Switch kustom presisi sesuai token Figma (pill hijau dengan thumb lingkaran putih)
  Widget _buildCustomSwitch({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48,
        height: 26,
        padding: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: value ? const Color(0xFF165540) : const Color(0xFFC8D7C3),
          borderRadius: BorderRadius.circular(13),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
