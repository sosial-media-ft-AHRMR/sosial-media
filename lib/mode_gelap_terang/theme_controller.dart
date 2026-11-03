import 'package:flutter/material.dart';
import '../theme/qcumber_colors.dart';

/// Pengontrol status tema global untuk Qcumber
/// Mengatur pergantian antara Mode Gelap (Dark Mode) dan Mode Terang (Light Mode)
/// Menggunakan gradasi resmi dari folder figma "mode gelap terang":
/// - Mode Terang: #C1E4B0 -> #E9F5E2 -> #FFFFFF
/// - Mode Gelap: #81A66B -> #536744 -> #25281E
class ThemeController extends ChangeNotifier {
  static final ThemeController instance = ThemeController._internal();
  ThemeController._internal();

  bool _isDarkMode = false;

  /// Status apakah saat ini aktif Mode Gelap
  bool get isDarkMode => _isDarkMode;

  /// Nilai ThemeMode untuk MaterialApp
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  /// Mengubah tema (toggle antara Gelap dan Terang)
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  /// Menetapkan mode gelap secara eksplisit
  void setDarkMode(bool value) {
    if (_isDarkMode != value) {
      _isDarkMode = value;
      notifyListeners();
    }
  }

  /// Gradasi latar belakang halaman utama sesuai mode aktif
  LinearGradient get pageGradient =>
      _isDarkMode ? QcumberColors.darkModeGradient : QcumberColors.lightModeGradient;

  /// Gradasi halaman pengaturan (dari atas ke bawah)
  LinearGradient get settingsGradient => _isDarkMode
      ? const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF81A66B),
            Color(0xFF455839),
            Color(0xFF22261C),
          ],
          stops: [0.0, 0.35, 0.75],
        )
      : const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFCFDEC7),
            Color(0xFFF7FAF5),
            Colors.white,
          ],
          stops: [0.0, 0.20, 0.50],
        );

  /// Warna teks utama (Judul, Header)
  Color get primaryTextColor =>
      _isDarkMode ? Colors.white : QcumberColors.primaryGreen;

  /// Warna teks sekunder / deskripsi
  Color get secondaryTextColor =>
      _isDarkMode ? const Color(0xFFC7E39F) : const Color(0xFF4A6B5D);

  /// Warna ikon
  Color get iconColor =>
      _isDarkMode ? const Color(0xFFC7E39F) : QcumberColors.primaryGreen;

  /// Warna garis pemisah / divider
  Color get dividerColor =>
      _isDarkMode ? const Color(0xFF3D4C36) : const Color(0xFFD0DFC9);

  /// Warna latar card / container
  Color get cardBackgroundColor =>
      _isDarkMode ? const Color(0xFF1E2319) : Colors.white;

  /// Asset path latar belakang sesuai mode
  String get backgroundAsset => _isDarkMode
      ? 'assets/images/mode_gelap.png'
      : 'assets/images/mode_terang.png';
}
