import 'package:flutter/material.dart';

/// PhoneFrame: Bingkai HP realistis (ukuran kanvas 402x874 px dengan border luar 8px)
/// Digunakan agar konsisten di seluruh layar saat dijalankan di Chrome/Desktop,
/// dan otomatis fleksibel jika di layar HP asli.
class PhoneFrame extends StatelessWidget {
  final Widget child;

  const PhoneFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Latar gelap elegan di luar bingkai
      body: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Container(
            width: 418, // 402 + 16 (border 8px kiri & kanan)
            height: 890, // 874 + 16 (border 8px atas & bawah)
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(44),
              border: Border.all(
                color: const Color(0xFF1E293B),
                width: 8,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(36),
              child: SizedBox(
                width: 402,
                height: 874,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
