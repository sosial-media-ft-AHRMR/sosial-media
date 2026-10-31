import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/post_item.dart';
import '../widgets/post_card.dart';

/// Halaman Profil Pengguna Sesuai 99% dengan Desain Figma User Profil.png & Component 7.png
/// - Cover Banner mentimun khas Qcumber (assets/feed/qcumber_cover.png)
/// - Tombol kembali (<) di dalam kotak hijau pastel (#9BBA7A / #A5C284) berukuran 44x44 dengan sudut melengkung 12px
/// - Kartu profil dengan sudut lengkung di kanan & kiri atas (Radius.circular(30)) dan gradasi lembut sage ke putih
/// - Avatar bulat diameter 130px dengan border putih solid 4px di kiri, bertumpuk di antara cover dan card
/// - Nama "Qcumber" (bold 32px, #165540) dan Handle "@qcumber" (18px, #165540) di samping avatar
/// - Bio "Lorem ipsum dolor sit amet, consectetur adipiscing elit." (#165540)
/// - Statistik "20RB Pengikut  0 Diikuti" (#165540)
/// - Tombol interaktif "Ikuti" / "Diikuti" sesuai 100% dengan Figma Component 7.png (tinggi 34px, radius 8px)
/// - Tombol "Bagikan Profil" (outline hijau tua #165540, tinggi 34px, radius 8px)
/// - Empty state "Tidak ada postingan" (#165540, 19px) tepat di bagian tengah bawah layar
class UserProfilePage extends StatefulWidget {
  final Map<String, dynamic>? creatorData;
  final bool showBackButton;

  const UserProfilePage({
    super.key,
    this.creatorData,
    this.showBackButton = true,
  });

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late bool _isFollowing;

  @override
  void initState() {
    super.initState();
    _isFollowing = widget.creatorData?['isFollowing'] ?? false;
  }

  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
    });

    final name = widget.creatorData?['username'] ?? 'Qcumber';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFollowing
              ? 'Sekarang Anda mengikuti $name'
              : 'Berhenti mengikuti $name',
          style: GoogleFonts.poppins(fontSize: 13, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF165540),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _shareProfile() {
    final handle = widget.creatorData?['handle'] ?? '@qcumber';
    Clipboard.setData(ClipboardData(text: 'https://qcumber.app/$handle'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tautan profil $handle berhasil disalin!',
          style: GoogleFonts.poppins(fontSize: 13, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF165540),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.creatorData ?? {};
    final String username = data['username'] ?? 'Qcumber';
    final String handle = data['handle'] ?? '@qcumber';
    final String bio = data['bio'] ??
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
    final String avatarUrl =
        data['avatarUrl'] ?? 'assets/feed/avatar_qcumber.jpg';
    final String coverUrl =
        data['coverUrl'] ?? 'assets/feed/qcumber_cover.png';
    final String followers = data['followers'] ?? '20RB';
    final String following = data['following'] ?? '0';

    // Daftar postingan jika akun kreator memiliki feed
    final List<PostItem> posts = [];
    final String? postImageUrl = data['postImageUrl'];
    if (postImageUrl != null && postImageUrl.isNotEmpty) {
      posts.add(
        PostItem(
          id: '${username.toLowerCase()}_post_0',
          username: username,
          location: data['subtitle'] ?? 'Seoul, South Korea',
          isVerified: data['isVerified'] ?? true,
          userAvatarUrl: avatarUrl,
          postImageUrl: postImageUrl,
          timeAgo: '24 jam yang lalu',
          caption: data['postQuote'] ??
              'A fresh slice of life. Menikmati setiap momen segar bersama Qcumber.',
          likeCount: 2540,
        ),
      );
    }

    final topPadding = MediaQuery.of(context).padding.top;
    final backBtnTop = topPadding > 0 ? topPadding + 6 : 32.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Banner & Identitas Stack (Sesuai 99% User Profil.png)
              SizedBox(
                height: 275,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Gambar Sampul / Banner Kulit Mentimun (Tinggi 184px sesuai frame Figma)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 184,
                      child: Image.asset(
                        coverUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: const Color(0xFF468812),
                        ),
                      ),
                    ),

                    // Tombol Kembali (<) Sesuai Figma: Kotak hijau pastel 44x44 px (X=20, Y=32)
                    if (widget.showBackButton)
                      Positioned(
                        top: backBtnTop,
                        left: 20,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFFA5C284).withValues(alpha: 0.85),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.chevron_left_rounded,
                                color: Color(0xFF165540),
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                      ),

                    // Latar Belakang Kartu Lengkung Mulai di Y = 175
                    // Gradasi vertikal presisi sesuai Figma: #B4CBA8 -> #D6E3CE -> #FFFFFF
                    Positioned(
                      top: 175,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFFB4CBA8),
                              Color(0xFFD6E3CE),
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                      ),
                    ),

                    // Avatar Bulat Berborder Putih Solid 4px (Diameter 130px, X=24, Y=138)
                    Positioned(
                      top: 138,
                      left: 24,
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            avatarUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: const Color(0xFFDEEBCE),
                              child: const Icon(
                                Icons.person,
                                size: 60,
                                color: Color(0xFF165540),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Nama Akun "Qcumber" & Handle "@qcumber" di Samping Kanan Avatar
                    Positioned(
                      top: 195,
                      left: 172,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username,
                            style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF165540),
                              letterSpacing: -0.5,
                              height: 1.1,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            handle,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF165540),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Konten Profil Lanjutan (Gradasi mengalir dari #D6E3CE ke #FFFFFF)
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFD6E3CE),
                      Color(0xFFEBF1E8),
                      Color(0xFFFFFFFF),
                      Color(0xFFFFFFFF),
                    ],
                    stops: [0.0, 0.25, 0.65, 1.0],
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 18),

                    // Bio Profil (Sesuai User Profil.png)
                    Text(
                      bio,
                      style: GoogleFonts.poppins(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF165540),
                        height: 1.35,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Statistik: "20RB Pengikut  0 Diikuti"
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF165540),
                        ),
                        children: [
                          TextSpan(
                            text: followers,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.5,
                            ),
                          ),
                          const TextSpan(
                            text: ' Pengikut    ',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                          TextSpan(
                            text: following,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.5,
                            ),
                          ),
                          const TextSpan(
                            text: ' Diikuti',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // 3. Tombol Aksi: "Ikuti" (Component 7.png) dan "Bagikan Profil"
                    Row(
                      children: [
                        // Tombol Ikuti / Diikuti (Toggle Interaktif Sesuai Component 7)
                        Expanded(
                          child: GestureDetector(
                            onTap: _toggleFollow,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: 34,
                              decoration: BoxDecoration(
                                color: _isFollowing
                                    ? Colors.transparent
                                    : const Color(0xFF165540),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFF165540),
                                  width: 1.2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  _isFollowing ? 'Diikuti' : 'Ikuti',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w600,
                                    color: _isFollowing
                                        ? const Color(0xFF165540)
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Tombol Bagikan Profil (Outline Hijau Tua #165540)
                        Expanded(
                          child: GestureDetector(
                            onTap: _shareProfile,
                            child: Container(
                              height: 34,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFF165540),
                                  width: 1.2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Bagikan Profil',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF165540),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // 4. Area Feed / Empty State "Tidak ada postingan"
                    if (posts.isEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 140, bottom: 200),
                        child: Center(
                          child: Text(
                            'Tidak ada postingan',
                            style: GoogleFonts.poppins(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF165540),
                              letterSpacing: 0.1,
                            ),
                          ),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 16, bottom: 100),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return PostCard(post: posts[index]);
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
