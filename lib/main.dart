import 'package:flutter/material.dart';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
              Color(0xFF7D9E69), // Hijau bagian atas
              Color(0xFFB5CDC3), // Mint lembut bagian tengah
              Color(0xFFF7FAF8), // Putih bersih bagian bawah
            ],
            stops: [0.0, 0.65, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2),

              // 1. Gambar Logo Monogram "QC"
              Image.asset(
                'assets/images/logo.png',
                width: 220,
                height: 220,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback jika file logo belum ditaruh
                  return const Icon(
                    Icons.spa,
                    size: 120,
                    color: Color(0xFF165540),
                  );
                },
              ),

              const SizedBox(height: 16),

              // 2. Tulisan "Qcumber"
              const Text(
                'Qcumber',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF165540),
                  fontSize: 38,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),

              const Spacer(flex: 3),

              // 3. Slogan di bagian bawah "A fresh slice of life"
              const Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'A fresh slice of life',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1E4D3E),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
