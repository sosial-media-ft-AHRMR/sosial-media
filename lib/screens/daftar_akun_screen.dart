import 'package:flutter/material.dart';
import 'package:sosial_media/screens/daftar_berhasil_screen.dart';

class DaftarAkunScreen extends StatefulWidget {
  const DaftarAkunScreen({super.key});

  @override
  State<DaftarAkunScreen> createState() => _DaftarAkunScreenState();
}

class _DaftarAkunScreenState extends State<DaftarAkunScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const DaftarBerhasilScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

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
              Color(0xFF82A86C), // Hijau mentimun
              Color(0xFFB3CEC9), // Mint lembut
              Color(0xFFF8FBFA), // Putih bersih
            ],
            stops: [0.0, 0.45, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 1. Tombol Kembali di Pojok Kiri Atas
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 4.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.chevron_left_rounded,
                      size: 36,
                      color: Color(0xFF165540),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),

              // 2. Konten Form Pendaftaran (Scrollable)
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
                  child: Column(
                    children: [
                      // Logo & Judul Layar
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
                      const SizedBox(height: 4),
                      const Text(
                        'Qcumber',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF165540),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Daftar Akun',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF165540),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Input 1: Nama Lengkap
                      _inputGroup(
                        label: 'Masukkan nama lengkap',
                        controller: _namaController,
                        hint: 'Alex Humber',
                      ),

                      const SizedBox(height: 14),

                      // Input 2: Email
                      _inputGroup(
                        label: 'Masukkan Email',
                        controller: _emailController,
                        hint: 'alexumber@gmail.com',
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 14),

                      // Input 3: Password
                      _inputGroup(
                        label: 'Masukkan Password',
                        controller: _passwordController,
                        hint: '••••••••',
                        obscureText: true,
                      ),

                      const SizedBox(height: 14),

                      // Input 4: Konfirmasi Password
                      _inputGroup(
                        label: 'Konfirmasi Password',
                        controller: _confirmController,
                        hint: '••••••••',
                        obscureText: true,
                      ),

                      const SizedBox(height: 32),

                      // Tombol Buat Akun Utama
                      SizedBox(
                        width: 210,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _handleRegister,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF165540),
                            foregroundColor: Colors.white,
                            elevation: 3,
                            shadowColor: const Color(0xFF165540).withValues(alpha: 0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            'Buat Akun',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
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

  Widget _inputGroup({
    required String label,
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          alignment: Alignment.center,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 14, color: Color(0xFF1E293B)),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}
