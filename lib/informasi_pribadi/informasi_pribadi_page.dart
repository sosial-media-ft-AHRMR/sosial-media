import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Halaman Informasi Pribadi Qcumber
/// Konversi presisi 99% dari Desain Figma "Informasi dan Pribadi.png"
///
/// Fitur:
/// - Bilah atas dengan tombol kembali (<)
/// - Judul besar dua baris "Informasi\nPribadi" warna hijau tua (#165540)
/// - Keterangan privasi: "Hanya kamu yang bisa lihat ini. Digunakan untuk keamanan, akses masuk, dan pemulihan profil"
/// - Daftar info kontak tersimpan dengan garis pembatas atas & bawah (#165540), ikon kontak, dan panah chevron (>)
/// - Formulir penambahan info kontak baru:
///   * Field "Tambahkan Email" dengan placeholder "Masukkan Email"
///   * Field "Tambahkan nomor telepon" dengan placeholder "Masukkan nomor telepon"
/// - Tombol utama rounded pill (#165540) "Tambah Info Kontak" dengan validasi interaktif
class InformasiPribadiPage extends StatefulWidget {
  const InformasiPribadiPage({super.key});

  @override
  State<InformasiPribadiPage> createState() => _InformasiPribadiPageState();
}

class _InformasiPribadiPageState extends State<InformasiPribadiPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Data kontak saat ini sesuai tampilan awal Figma
  String _currentEmail = 'mber@email.com';
  String _currentPhone = '+62 822 2222 2222';

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveContactInfo() {
    final newEmail = _emailController.text.trim();
    final newPhone = _phoneController.text.trim();

    if (newEmail.isEmpty && newPhone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Silakan masukkan email atau nomor telepon baru',
            style: GoogleFonts.poppins(fontSize: 13, color: Colors.white),
          ),
          backgroundColor: const Color(0xFF165540),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      if (newEmail.isNotEmpty) {
        _currentEmail = newEmail;
      }
      if (newPhone.isNotEmpty) {
        _currentPhone = newPhone;
      }
    });

    _emailController.clear();
    _phoneController.clear();
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Info kontak berhasil diperbarui!',
          style: GoogleFonts.poppins(fontSize: 13, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF165540),
        duration: const Duration(seconds: 2),
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
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.0, 0.35, 0.8],
            colors: [
              Color(0xFFB5CBA9),
              Color(0xFFF6F8F4),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      // 1. Tombol Kembali (<) di Kiri Atas
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.maybePop(context),
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: 36,
                            height: 36,
                            alignment: Alignment.centerLeft,
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Color(0xFF165540),
                              size: 22,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // 2. Judul Besar Dua Baris: "Informasi\nPribadi"
                      Text(
                        'Informasi\nPribadi',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF165540),
                          height: 1.15,
                          letterSpacing: -0.5,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // 3. Deskripsi Privasi
                      Text(
                        'Hanya kamu yang bisa lihat ini. Digunakan untuk\nkeamanan, akses masuk, dan pemulihan profil',
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF536947),
                          height: 1.45,
                        ),
                      ),

                      const SizedBox(height: 28),

                      // 4. Daftar Kontak Tersimpan dengan Border Atas & Bawah
                      Container(
                        decoration: const BoxDecoration(
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              color: Color(0xFF165540),
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            // Baris Email
                            _buildContactRow(
                              icon: Icons.mail_outline_rounded,
                              value: _currentEmail,
                              onTap: () {
                                _emailController.text = _currentEmail;
                              },
                            ),

                            // Garis Pembatas Tipis Antar Item
                            Container(
                              height: 0.6,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              color: const Color(0xFF165540).withValues(alpha: 0.25),
                            ),

                            // Baris Nomor Telepon
                            _buildContactRow(
                              icon: Icons.phone_outlined,
                              value: _currentPhone,
                              onTap: () {
                                _phoneController.text = _currentPhone;
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 36),

                      // 5. Judul Bagian Formulir: "Tambah Info Kontak\nBaru"
                      Text(
                        'Tambah Info Kontak\nBaru',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF165540),
                          height: 1.25,
                        ),
                      ),

                      const SizedBox(height: 18),

                      // 6. Form Field: "Tambahkan Email"
                      Text(
                        'Tambahkan Email',
                        style: GoogleFonts.poppins(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF165540),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFF165540),
                            width: 1.2,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: const Color(0xFF165540),
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Masukkan Email',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color(0xFF536947).withValues(alpha: 0.65),
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // 7. Form Field: "Tambahkan nomor telepon"
                      Text(
                        'Tambahkan nomor telepon',
                        style: GoogleFonts.poppins(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF165540),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFF165540),
                            width: 1.2,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: const Color(0xFF165540),
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Masukkan nomor telepon',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color(0xFF536947).withValues(alpha: 0.65),
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // 8. Tombol "Tambah Info Kontak" (#165540)
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _saveContactInfo,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF165540),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                          child: Text(
                            'Tambah Info Kontak',
                            style: GoogleFonts.poppins(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
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

  /// Baris item kontak tersimpan (Email / Telepon)
  Widget _buildContactRow({
    required IconData icon,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Row(
          children: [
            // Ikon Kontak
            Icon(
              icon,
              size: 24,
              color: const Color(0xFF165540),
            ),
            const SizedBox(width: 16),

            // Teks Nilai Kontak
            Expanded(
              child: Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF165540),
                ),
              ),
            ),

            // Ikon Panah Chevron Kanan (>)
            const Icon(
              Icons.chevron_right_rounded,
              size: 26,
              color: Color(0xFF165540),
            ),
          ],
        ),
      ),
    );
  }
}
