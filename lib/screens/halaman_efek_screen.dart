import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/qcumber_colors.dart';

/// Model untuk filter/efek kamera
class CameraEffectItem {
  final String id;
  final String name;
  final IconData icon;
  final Color effectColor;
  final double opacity;
  final BlendMode blendMode;

  const CameraEffectItem({
    required this.id,
    required this.name,
    required this.icon,
    required this.effectColor,
    this.opacity = 0.25,
    this.blendMode = BlendMode.color,
  });
}

/// Halaman Efek Kamera Story / New Slice Qcumber
class HalamanEfekScreen extends StatefulWidget {
  const HalamanEfekScreen({super.key});

  @override
  State<HalamanEfekScreen> createState() => _HalamanEfekScreenState();
}

class _HalamanEfekScreenState extends State<HalamanEfekScreen> {
  // Daftar filter efek kamera khas Qcumber
  final List<CameraEffectItem> _effects = const [
    CameraEffectItem(
      id: 'normal',
      name: 'Normal',
      icon: Icons.auto_awesome_mosaic_outlined,
      effectColor: Colors.transparent,
      opacity: 0.0,
      blendMode: BlendMode.srcOver,
    ),
    CameraEffectItem(
      id: 'neon_glow',
      name: 'Neon Glow',
      icon: Icons.electric_bolt_rounded,
      effectColor: Color(0xFFC7E39F),
      opacity: 0.30,
      blendMode: BlendMode.screen,
    ),
    CameraEffectItem(
      id: 'emerald_tint',
      name: 'Emerald',
      icon: Icons.eco_rounded,
      effectColor: Color(0xFF165540),
      opacity: 0.35,
      blendMode: BlendMode.colorBurn,
    ),
    CameraEffectItem(
      id: 'vintage_sage',
      name: 'Vintage Sage',
      icon: Icons.filter_vintage_rounded,
      effectColor: Color(0xFF82A86C),
      opacity: 0.28,
      blendMode: BlendMode.softLight,
    ),
    CameraEffectItem(
      id: 'midnight_shade',
      name: 'Midnight',
      icon: Icons.nightlight_round,
      effectColor: Color(0xFF0F2B1D),
      opacity: 0.45,
      blendMode: BlendMode.darken,
    ),
    CameraEffectItem(
      id: 'sparkle',
      name: 'Sparkle ✨',
      icon: Icons.auto_awesome_rounded,
      effectColor: Color(0xFFE2F0D9),
      opacity: 0.25,
      blendMode: BlendMode.overlay,
    ),
  ];

  int _selectedEffectIndex = 1; // Default: Neon Glow
  bool _isFlashOn = false;
  bool _isFrontCamera = false;
  double _effectIntensity = 0.65;

  void _capturePhoto() {
    final effect = _effects[_selectedEffectIndex];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: QcumberColors.limeGreen),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Foto berhasil diambil dengan efek "${effect.name}"!',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 13),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF102617),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
    Navigator.pop(context, effect.name);
  }

  @override
  Widget build(BuildContext context) {
    final currentEffect = _effects[_selectedEffectIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Live Camera Viewfinder dengan Simulasi Efek
          Image.asset(
            'assets/feed/cake_swan.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF12281C),
                      Color(0xFF1D4733),
                      Color(0xFF0E1A13),
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.camera_rounded,
                    size: 80,
                    color: QcumberColors.limeGreen,
                  ),
                ),
              );
            },
          ),

          // 2. Layer Filter/Efek Berdasarkan Pilihan
          if (currentEffect.effectColor != Colors.transparent)
            Positioned.fill(
              child: Container(
                color: currentEffect.effectColor.withValues(
                  alpha: currentEffect.opacity * _effectIntensity,
                ),
              ),
            ),

          // 3. Vignette & Gradien Kontrol Atas / Bawah
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.20, 0.70, 1.0],
                  colors: [
                    Colors.black.withValues(alpha: 0.75),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.85),
                  ],
                ),
              ),
            ),
          ),

          // 4. Header Atas: Tombol Tutup, Flash, Switch Camera, Grid
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tombol Tutup (X)
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.close_rounded, color: Colors.white, size: 22),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),

                    // Label Halaman Efek
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF165540).withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: QcumberColors.limeGreen, width: 1),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.auto_awesome, size: 14, color: QcumberColors.limeGreen),
                          const SizedBox(width: 6),
                          Text(
                            'Halaman Efek',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Kontrol Cepat (Flash & Flip)
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            _isFlashOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
                            color: _isFlashOn ? QcumberColors.limeGreen : Colors.white70,
                          ),
                          onPressed: () {
                            setState(() {
                              _isFlashOn = !_isFlashOn;
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.flip_camera_ios_rounded, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              _isFrontCamera = !_isFrontCamera;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 5. Area Bawah: Slider Intensitas Efek & Carousel Pilihan Efek
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Label Efek Aktif & Slider Intensitas
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          currentEffect.name,
                          style: GoogleFonts.poppins(
                            color: QcumberColors.limeGreen,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            shadows: [
                              const Shadow(blurRadius: 8, color: Colors.black),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 140,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: QcumberColors.limeGreen,
                              inactiveTrackColor: Colors.white24,
                              thumbColor: Colors.white,
                              trackHeight: 3,
                              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                            ),
                            child: Slider(
                              value: _effectIntensity,
                              min: 0.1,
                              max: 1.0,
                              onChanged: (val) {
                                setState(() {
                                  _effectIntensity = val;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Carousel Efek Kamera
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _effects.length,
                      itemBuilder: (context, index) {
                        final effect = _effects[index];
                        final isSelected = _selectedEffectIndex == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedEffectIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected
                                        ? const Color(0xFF165540)
                                        : Colors.black54,
                                    border: Border.all(
                                      color: isSelected
                                          ? QcumberColors.limeGreen
                                          : Colors.white30,
                                      width: isSelected ? 2.5 : 1.2,
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: QcumberColors.limeGreen.withValues(alpha: 0.5),
                                              blurRadius: 10,
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Icon(
                                    effect.icon,
                                    color: isSelected ? QcumberColors.limeGreen : Colors.white70,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  effect.name,
                                  style: GoogleFonts.poppins(
                                    color: isSelected ? Colors.white : Colors.white60,
                                    fontSize: 10,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Tombol Shutter Ambil Foto & Galeri
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Galeri Button
                        IconButton(
                          icon: const Icon(Icons.photo_library_outlined, color: Colors.white, size: 28),
                          onPressed: () => Navigator.pop(context),
                        ),

                        // Shutter Capture Button
                        GestureDetector(
                          onTap: _capturePhoto,
                          child: Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    QcumberColors.primaryGreen,
                                    QcumberColors.limeGreen,
                                  ],
                                ),
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),

                        // Tombol Reset Efek
                        IconButton(
                          icon: const Icon(Icons.refresh_rounded, color: Colors.white, size: 28),
                          onPressed: () {
                            setState(() {
                              _selectedEffectIndex = 0;
                              _effectIntensity = 0.5;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
