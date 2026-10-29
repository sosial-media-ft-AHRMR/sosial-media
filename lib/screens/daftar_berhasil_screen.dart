import 'package:flutter/material.dart';
import 'package:sosial_media/screens/login_screen.dart';

class DaftarBerhasilScreen extends StatelessWidget {
  const DaftarBerhasilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF82A86C), // Hijau segar
              Color(0xFFB3CEC9), // Mint lembut
              Color(0xFFF8FBFA), // Putih bersih
            ],
            stops: [0.0, 0.45, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 16),

                // 1. Pesan Sambutan Atas
                Column(
                  children: const [
                    Text(
                      'Welcome to the circle, Alexumber!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF165540),
                        height: 1.25,
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Akunmu udah siap. Yuk intip apa yang lagi seger dan rame hari ini',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF2D4F41),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),

                // 2. Ikon Sukses & Logo Tengah
                Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFF165540),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF165540).withValues(alpha: 0.35),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 72,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Image.asset(
                      'assets/images/logo.png',
                      width: 90,
                      height: 90,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.eco_rounded,
                          size: 70,
                          color: Color(0xFF165540),
                        );
                      },
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Qcumber',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF165540),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),

                // 3. Tombol "Masuk ke Beranda"
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SizedBox(
                    width: 250,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        // Kembali ke Halaman Login
                        Navigator.of(context).pushAndRemoveUntil(
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) =>
                                const LoginScreen(),
                            transitionsBuilder:
                                (context, animation, secondaryAnimation, child) {
                              return FadeTransition(opacity: animation, child: child);
                            },
                            transitionDuration: const Duration(milliseconds: 300),
                          ),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF165540),
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shadowColor: const Color(0xFF165540).withValues(alpha: 0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: const Text(
                        'Masuk ke Beranda',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
