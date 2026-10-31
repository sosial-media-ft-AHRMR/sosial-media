import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../profil/profil.dart';
import '../theme/qcumber_colors.dart';

/// Halaman Pencarian Qcumber Sesuai 100% dengan Figma Searching-1.png & Searching.png
/// - Saat input kosong: history dihilangkan (tampilan bersih seperti Gambar 1)
/// - Saat mencari: hasil profil muncul (seperti Gambar 2)
/// - Saat item profil diklik: membuka profil persis sesuai profil yang ditekan (seperti Gambar 1)
/// - Menggunakan gradasi latar belakang resmi QcumberColors.pageBackgroundGradient
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _allCreators = [
    {
      'username': 'Qcumber',
      'handle': '@qcumber',
      'subtitle': 'A fresh slice of life',
      'followers': '20RB',
      'following': '0',
      'avatarUrl': 'assets/feed/avatar_qcumber.jpg',
      'coverUrl': 'assets/feed/qcumber_cover.png',
      'bio': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'joinedDate': 'Bergabung April 2023',
      'postQuote': '',
      'postImageUrl': '',
      'isFollowing': false,
    },
    {
      'username': 'Alexumber',
      'handle': '@acumber',
      'subtitle': 'New York, Amerika Serikat',
      'followers': '15RB',
      'following': '300',
      'avatarUrl': 'assets/feed/alexumber_avatar.jpg',
      'coverUrl': 'assets/feed/alexumber_cover.jpg',
      'bio': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'joinedDate': 'Bergabung April 2023',
      'postQuote': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'postImageUrl': 'assets/feed/alexumber_post1.jpg',
      'isFollowing': false,
    },
    {
      'username': 'Your.Idol',
      'handle': '@your.idol',
      'subtitle': 'Music & Daily Life',
      'followers': '15RB',
      'following': '120',
      'avatarUrl': 'assets/feed/avatar_your_idol.png',
      'coverUrl': 'assets/feed/alexumber_cover.jpg',
      'bio': 'Music, daily life, and fresh acoustic moments 🎵',
      'joinedDate': 'Bergabung Januari 2023',
      'postQuote': 'Melodi terbaik tercipta saat hati merasa tenang dan bebas.',
      'postImageUrl': 'assets/feed/post_bali.png',
      'isFollowing': true,
    },
    {
      'username': 'thv',
      'handle': '@thv',
      'subtitle': 'Seoul, South Korea',
      'followers': '128RB',
      'following': '15',
      'avatarUrl': 'assets/feed/avatar_thv.png',
      'coverUrl': 'assets/feed/alexumber_cover.jpg',
      'bio': 'Seoul vibes. Winter rain & city lights.',
      'joinedDate': 'Bergabung Desember 2022',
      'postQuote': 'Rainy days in Seoul hit differently when looking outside the car window.',
      'postImageUrl': 'assets/feed/post_thv.png',
      'isFollowing': false,
    },
    {
      'username': 'Shawn',
      'handle': '@shawn',
      'subtitle': 'Books & Coffee',
      'followers': '85RB',
      'following': '240',
      'avatarUrl': 'assets/feed/avatar_shawn.png',
      'coverUrl': 'assets/feed/alexumber_cover.jpg',
      'bio': 'Coffee enthusiast & book reader. Why We Sleep is a must-read.',
      'joinedDate': 'Bergabung Maret 2023',
      'postQuote':
          'A cup of dark roast and a good chapter before the day starts.',
      'postImageUrl': 'assets/feed/post_shawn.png',
      'isFollowing': false,
    },
    {
      'username': 'Peter',
      'handle': '@peter',
      'subtitle': 'Film & Visual Arts',
      'followers': '42RB',
      'following': '95',
      'avatarUrl': 'assets/feed/avatar_peter.png',
      'coverUrl': 'assets/feed/alexumber_cover.jpg',
      'bio': 'Cinematography and film photography.',
      'joinedDate': 'Bergabung Februari 2023',
      'postQuote': 'Capture the shadows first; light will always find its way.',
      'postImageUrl': 'assets/feed/post_peter.png',
      'isFollowing': false,
    },
    {
      'username': 'MrShadow',
      'handle': '@mrshadow',
      'subtitle': 'Amsterdam Street Life',
      'followers': '19RB',
      'following': '310',
      'avatarUrl': 'assets/feed/avatar_mrshadow.png',
      'coverUrl': 'assets/feed/alexumber_cover.jpg',
      'bio': 'Amsterdam canals, bicycles, and neon night photography.',
      'joinedDate': 'Bergabung Mei 2023',
      'postQuote': 'Night walks along Amsterdam canals never get old.',
      'postImageUrl': 'assets/feed/post_amsterdam.png',
      'isFollowing': false,
    },
  ];

  // Awalnya KOSONG agar tidak ada history yang muncul (Sesuai Gambar 1)
  List<Map<String, dynamic>> _filteredCreators = [];

  @override
  void initState() {
    super.initState();
    _filteredCreators = [];
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      // Jika input kosong, hilangkan seluruh daftar history (Sesuai Gambar 1)
      if (query.isEmpty) {
        _filteredCreators = [];
      } else {
        // Tampilkan hanya akun/profil yang cocok saat diketik (Sesuai Gambar 2)
        _filteredCreators = _allCreators.where((creator) {
          final username = creator['username'].toString().toLowerCase();
          final subtitle = creator['subtitle'].toString().toLowerCase();
          final handle = creator['handle'].toString().toLowerCase();
          return username.contains(query) ||
              subtitle.contains(query) ||
              handle.contains(query);
        }).toList();
      }
    });
  }

  /// Membuka profil persis sesuai profil pencarian yang ditekan (Sesuai Desain Figma Profil)
  void _openProfile(Map<String, dynamic> creator) {
    if (creator['username'] == 'Alexumber') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyProfilePage(showBackButton: true),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              UserProfilePage(creatorData: creator, showBackButton: true),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      // Gradasi warna latar belakang resmi sesuai Foto Kedua
      decoration: const BoxDecoration(
        gradient: QcumberColors.pageBackgroundGradient,
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // 1. Judul "Pencarian" (Sesuai Figma Searching-1.png & Gambar 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Pencarian',
                style: GoogleFonts.poppins(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: QcumberColors.primaryGreen,
                  letterSpacing: -0.5,
                ),
              ),
            ),

            const SizedBox(height: 18),

            // 2. Kotak Input Pencarian dengan Border Tipis & Ikon Kaca Pembesar (Gambar 1 & 2)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F5EE),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black, width: 1.2),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: QcumberColors.primaryGreen,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF7A977A),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.search_rounded,
                      color: QcumberColors.primaryGreen,
                      size: 26,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 3. Daftar Hasil Pencarian (KOSONG saat belum mencari, MUNCUL saat diketik)
            Expanded(
              child: _filteredCreators.isEmpty
                  ? const SizedBox.shrink()
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      itemCount: _filteredCreators.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 18),
                      itemBuilder: (context, index) {
                        final creator = _filteredCreators[index];
                        return _buildCreatorItem(creator);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /// Item profil hasil pencarian sesuai Gambar 2 Figma
  /// Tapping profil membuka halaman profil dinamis sesuai akun yang ditekan
  Widget _buildCreatorItem(Map<String, dynamic> creator) {
    final bool isFollowing = creator['isFollowing'] as bool;

    return GestureDetector(
      onTap: () => _openProfile(creator),
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar Bulat menggunakan Image.asset
          Container(
            width: 54,
            height: 54,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: ClipOval(
              child: Image.asset(
                creator['avatarUrl'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFFE2E8F0),
                  child: const Icon(
                    Icons.person,
                    color: QcumberColors.primaryGreen,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 14),

          // Info Kreator (Nama, Slogan, Pengikut)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  creator['username'],
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: QcumberColors.primaryGreen,
                  ),
                ),
                Text(
                  creator['subtitle'],
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: QcumberColors.sageText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${creator['followers']} Pengikut',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: QcumberColors.primaryGreen,
                  ),
                ),
              ],
            ),
          ),

          // Tombol "Ikuti" (atau "Mengikuti")
          GestureDetector(
            onTap: () {
              setState(() {
                creator['isFollowing'] = !isFollowing;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isFollowing
                        ? 'Berhenti mengikuti ${creator['username']}'
                        : 'Sekarang Anda mengikuti ${creator['username']}',
                    style: GoogleFonts.poppins(fontSize: 13),
                  ),
                  backgroundColor: QcumberColors.primaryGreen,
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isFollowing ? Colors.white : QcumberColors.primaryGreen,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: QcumberColors.primaryGreen,
                  width: 1.5,
                ),
              ),
              child: Text(
                isFollowing ? 'Mengikuti' : 'Ikuti',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isFollowing
                      ? QcumberColors.primaryGreen
                      : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
