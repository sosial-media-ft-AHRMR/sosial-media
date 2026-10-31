import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/post_item.dart';
import '../theme/qcumber_colors.dart';
import '../widgets/post_card.dart';
import 'edit_profil_page.dart';

/// Halaman Profil Pribadi (My Profile) Sesuai 99% dengan Desain Figma My Profile.png
/// - Banner Cover Arsitektur hitam-putih Park Ave
/// - Sudut lengkung lembut di kanan dan kiri atas kartu profil
/// - Avatar bulat dengan border putih tebal di kiri atas
/// - Nama "Alexumber" & Handle "@acumber"
/// - Bio "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
/// - Statistik "15RB Pengikut  300 Diikuti"
/// - Tombol "Edit Profil" (menavigasi ke EditProfilePage dan memperbarui data secara dinamis)
/// - Tombol "Bagikan Profil"
/// - Feed postingan berlekuk (NotchedPhotoClipper) dengan pemandangan arsitektur
class MyProfilePage extends StatefulWidget {
  final bool showBackButton;

  const MyProfilePage({
    super.key,
    this.showBackButton = false,
  });

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  String _name = 'Alexumber';
  String _handle = '@acumber';
  String _bio = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
  final String _avatarUrl = 'assets/feed/alexumber_avatar.jpg';
  final String _coverUrl = 'assets/feed/alexumber_cover.jpg';
  final String _followers = '15RB';
  final String _following = '300';

  late List<PostItem> _myPosts;

  @override
  void initState() {
    super.initState();
    _initializePosts();
  }

  void _initializePosts() {
    _myPosts = [
      PostItem(
        id: 'alexumber_post_1',
        username: _name,
        location: 'New York, Amerika Serikat',
        isVerified: true,
        userAvatarUrl: _avatarUrl,
        postImageUrl: 'assets/feed/alexumber_post1.jpg',
        timeAgo: '3 jam yang lalu',
        caption:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ...more',
        likeCount: 1540,
      ),
      PostItem(
        id: 'alexumber_post_2',
        username: _name,
        location: 'Manhattan, New York',
        isVerified: true,
        userAvatarUrl: _avatarUrl,
        postImageUrl: 'assets/feed/alexumber_post2.jpg',
        timeAgo: '1 hari yang lalu',
        caption:
            'Sunset over 42nd Street and Chrysler Building. The golden hour hits the concrete canyon just right.',
        likeCount: 2890,
      ),
      PostItem(
        id: 'alexumber_post_3',
        username: _name,
        location: 'Empire State, New York',
        isVerified: true,
        userAvatarUrl: _avatarUrl,
        postImageUrl: 'assets/feed/alexumber_post3.jpg',
        timeAgo: '3 hari yang lalu',
        caption: 'Night lights and towering monoliths of steel and stone.',
        likeCount: 3120,
      ),
      PostItem(
        id: 'alexumber_post_4',
        username: _name,
        location: 'Brooklyn Bridge, New York',
        isVerified: true,
        userAvatarUrl: _avatarUrl,
        postImageUrl: 'assets/feed/alexumber_post4.jpg',
        timeAgo: '5 hari yang lalu',
        caption:
            'Morning mist over the suspension cables. New day, new perspective.',
        likeCount: 4210,
      ),
    ];
  }

  Future<void> _openEditProfile() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          initialName: _name,
          initialUsername: _handle,
          initialBio: _bio,
          avatarUrl: _avatarUrl,
          coverUrl: _coverUrl,
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        if (result['name'] != null && result['name'].toString().isNotEmpty) {
          _name = result['name'];
        }
        if (result['handle'] != null &&
            result['handle'].toString().isNotEmpty) {
          _handle = result['handle'];
        }
        if (result['bio'] != null) {
          _bio = result['bio'];
        }
        _initializePosts();
      });
    }
  }

  void _shareProfile() {
    Clipboard.setData(ClipboardData(text: 'https://qcumber.app/$_handle'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tautan profil $_handle berhasil disalin!',
          style: GoogleFonts.poppins(fontSize: 13, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF165540),
        duration: const Duration(seconds: 1),
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
          gradient: QcumberColors.pageBackgroundGradient,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Cover Banner & Header Stack (Sesuai My Profile.png)
              SizedBox(
                height: 240,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Gambar Sampul Arsitektur Park Ave
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 185,
                      child: Image.asset(
                        _coverUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: const Color(0xFF222B27),
                        ),
                      ),
                    ),

                    // Tombol Kembali (<) Jika halaman dibuka secara push route
                    if (widget.showBackButton)
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 8,
                        left: 18,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: const Color(0xFFC7E39F).withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.chevron_left_rounded,
                                color: Color(0xFF165540),
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),

                    // Kontainer Lengkung Mulai di Y = 168 (Membentuk latar belakang melengkung)
                    Positioned(
                      top: 168,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFE5EFE2),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                      ),
                    ),

                    // Avatar Bulat Berborder Putih Tebal di Kiri Bawah Cover
                    Positioned(
                      top: 115,
                      left: 20,
                      child: Container(
                        width: 104,
                        height: 104,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.12),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            _avatarUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: const Color(0xFFDEEBCE),
                              child: const Icon(
                                Icons.person,
                                size: 54,
                                color: Color(0xFF165540),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Nama Akun "Alexumber" dan Handle "@acumber" di Kanan Avatar
                    Positioned(
                      top: 178,
                      left: 138,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _name,
                            style: GoogleFonts.poppins(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF165540),
                              height: 1.1,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _handle,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
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

              // 2. Bagian Konten Profil di Bawah Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: const BoxDecoration(
                  color: Color(0xFFE5EFE2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Bio Profil (Sesuai My Profile.png)
                    Text(
                      _bio,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF165540),
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Statistik Pengikut & Diikuti (15RB Pengikut  300 Diikuti)
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF165540),
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: _followers,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const TextSpan(
                            text: ' Pengikut    ',
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: _following,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const TextSpan(
                            text: ' Diikuti',
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Baris Dua Tombol Aksi: "Edit Profil" & "Bagikan Profil"
                    Row(
                      children: [
                        // Tombol Edit Profil
                        Expanded(
                          child: GestureDetector(
                            onTap: _openEditProfile,
                            child: Container(
                              height: 38,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFF165540),
                                  width: 1.5,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Edit Profil',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF165540),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Tombol Bagikan Profil
                        Expanded(
                          child: GestureDetector(
                            onTap: _shareProfile,
                            child: Container(
                              height: 38,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFF165540),
                                  width: 1.5,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Bagikan Profil',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF165540),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),

              // 3. Feed Postingan Notched Foto (Sesuai My Profile.png)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 8, bottom: 120),
                itemCount: _myPosts.length,
                itemBuilder: (context, index) {
                  return PostCard(post: _myPosts[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

