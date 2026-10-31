import 'package:flutter/material.dart';

/// Palet warna dan gradien resmi Qcumber sesuai 100% dengan token Figma
/// Diambil langsung dari Color Palette (10 colors) & Gradients (3 gradients)
class QcumberColors {
  // 10 Warna Palet Resmi Figma
  static const Color black = Color(0xFF000000);
  static const Color darkGreen = Color(0xFF134D39);
  static const Color primaryGreen = Color(0xFF165540);
  static const Color tealGreen = Color(0xFF2C7769);
  static const Color sageText = Color(0xFF536947);
  static const Color cucumberGreen = Color(0xFF82A86C);
  static const Color lightSage = Color(0xFFAED09B);
  static const Color limeGreen = Color(0xFFC7E39F);
  static const Color grayBg = Color(0xFFD9D9D9);
  static const Color white = Color(0xFFFFFFFF);

  // 3 Gradien Resmi Figma
  /// Gradien 1: Border Stories ("Slice") - Hijau Tua ke Hijau Muda
  static const LinearGradient storyBorderGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF165540),
      Color(0xFFC7E39F),
    ],
  );

  /// Gradien 2: Mid Green Gradient
  static const LinearGradient midGreenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF536947),
      Color(0xFF2C7769),
    ],
  );

  /// Gradien 3: Header & Background Gradient (Putih ke Hijau Sage Lembut)
  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 0.94],
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFAED09B),
    ],
  );

  /// Gradasi warna latar belakang resmi Qcumber (Sesuai Foto Kedua / Figma)
  /// Konsisten pada seluruh tampilan (Feed, Pencarian, Profil):
  /// Putih (#FFFFFF) di kiri-bawah ke Hijau Sage (#AED09B) di kanan-atas
  static const LinearGradient pageBackgroundGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 0.45, 1.0],
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFF3F8F1),
      Color(0xFFAED09B),
    ],
  );

  /// Background Glow Radial di pojok kanan atas
  static const RadialGradient backgroundGlow = RadialGradient(
    center: Alignment(0.85, -0.15),
    radius: 1.25,
    colors: [
      Color.fromRGBO(134, 171, 115, 0.65),
      Color.fromRGBO(254, 252, 252, 0.0),
    ],
    stops: [0.20, 0.90],
  );
}

