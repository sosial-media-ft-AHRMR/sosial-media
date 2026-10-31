import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/post_item.dart';
import '../theme/qcumber_colors.dart';
import '../widgets/post_card.dart';

/// Halaman Profil Pengguna Sesuai 100% dengan Foto Kedua (Alexumber Figma Reference)
/// - Menghilangkan tabrakan avatar dan nama pengguna (Avatar di kiri dan Nama/Handle di kanan bersebelahan)
/// - Mengganti tombol Edit/Bagikan Profil menjadi "Pesan" dan "Ikuti" (interaktif toggle)
/// - Menghadirkan kembali kartu postingan quote/caption ("stop the wedding...") sesuai permintaan pengguna
/// - Menambahkan beberapa postingan dengan ilustrasi fotografi arsitektur & kota
/// - Gradasi latar belakang konsisten dengan QcumberColors.pageBackgroundGradient
/// - Data terintegrasi dinamis sesuai creator yang diklik dari pencarian
class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> creatorData;
  final bool showBackButton;

  const ProfilePage({
    super.key,
    required this.creatorData,
    this.showBackButton = true,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late bool _isFollowing;

  // Status interaktif untuk kartu quote / caption postingan 1
  bool _isQuote1Liked = false;
  int _quote1LikeCount = 20000;
  bool _isQuote1Saved = false;

  // Status interaktif untuk kartu quote / caption postingan 2
  bool _isQuote2Liked = false;
  int _quote2LikeCount = 12000;
  bool _isQuote2Saved = false;

  @override
  void initState() {
    super.initState();
    _isFollowing = widget.creatorData['isFollowing'] ?? false;
  }

  /// Menghasilkan daftar postingan foto untuk profil dengan kartu foto berlekuk (NotchedPhotoClipper)
  List<PostItem> _getProfilePosts(String username, String avatarUrl) {
    final List<PostItem> posts = [];

    // Jika profil berasal dari pencarian spesifik dengan postingan khas (misal thv, Shawn, Peter, dsb)
    final String? mainPostImage = widget.creatorData['postImageUrl'];
    if (mainPostImage != null && !mainPostImage.contains('alexumber_post')) {
      posts.add(
        PostItem(
          id: '${username.toLowerCase()}_post_0',
          username: username,
          location: widget.creatorData['subtitle'] ?? 'Seoul, South Korea',
          isVerified: widget.creatorData['isVerified'] ?? true,
          userAvatarUrl: avatarUrl,
          postImageUrl: mainPostImage,
          timeAgo: '24 jam yang lalu',
          caption: widget.creatorData['postQuote'] ?? 'A fresh slice of life. Menikmati setiap momen segar bersama Qcumber.',
          likeCount: 2540,
        ),
      );
    }

    // Postingan Foto 1 (Sesuai Foto Kedua): Pemandangan gedung pencakar langit dari bawah
    posts.add(
      PostItem(
        id: '${username.toLowerCase()}_post_1',
        username: username,
        location: 'New York, Amerika Serikat',
        isVerified: true,
        userAvatarUrl: avatarUrl,
        postImageUrl: 'assets/feed/alexumber_post1.jpg',
        timeAgo: '3 jam yang lalu',
        caption: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ...more',
        likeCount: 1540,
      ),
    );

    // Postingan Foto 2: Senja di 42nd Street & Gedung Chrysler
    posts.add(
      PostItem(
        id: '${username.toLowerCase()}_post_2',
        username: username,
        location: 'Manhattan, New York',
        isVerified: true,
        userAvatarUrl: avatarUrl,
        postImageUrl: 'assets/feed/alexumber_post2.jpg',
        timeAgo: '1 hari yang lalu',
        caption: 'Sunset over 42nd Street and Chrysler Building. The golden hour hits the concrete canyon just right. Menikmati hangatnya sore di antara arsitektur klasik.',
        likeCount: 2890,
      ),
    );

    // Postingan Foto 3: Suasana malam berkabut di Empire State Building
    posts.add(
      PostItem(
        id: '${username.toLowerCase()}_post_3',
        username: username,
        location: 'Midtown, New York',
        isVerified: true,
        userAvatarUrl: avatarUrl,
        postImageUrl: 'assets/feed/alexumber_post3.jpg',
        timeAgo: '3 hari yang lalu',
        caption: 'Empire State in all its nocturnal glory. Quiet moments above the bustling streets. Suasana malam New York yang penuh inspirasi dan ketenangan.',
        likeCount: 3410,
      ),
    );

    // Postingan Foto 4: Sudut Broadway & Plang Kereta Bawah Tanah (Subway)
    posts.add(
      PostItem(
        id: '${username.toLowerCase()}_post_4',
        username: username,
        location: 'Broadway, New York',
        isVerified: true,
        userAvatarUrl: avatarUrl,
        postImageUrl: 'assets/feed/alexumber_post4.jpg',
        timeAgo: '5 hari yang lalu',
        caption: 'Subway vibes & Broadway lights. Where every corner has a story to tell. Melangkah menyusuri lorong kota dan menemukan cerita baru di setiap sudut.',
        likeCount: 1980,
      ),
    );

    return posts;
  }

  @override
  Widget build(BuildContext context) {
    final creator = widget.creatorData;
    final String username = creator['username'] ?? 'Alexumber';
    final String handle = creator['handle'] ?? '@${username.toLowerCase()}';
    final String avatarUrl =
        creator['avatarUrl'] ?? 'assets/feed/alexumber_avatar.jpg';
    final String coverUrl =
        creator['coverUrl'] ?? 'assets/feed/alexumber_cover.jpg';
    final String bio =
        creator['bio'] ??
        creator['subtitle'] ??
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
    final String followers = creator['followers'] ?? '15RB';
    final String following = creator['following'] ?? '300';
    final String postQuote =
        creator['postQuote'] ??
        'stop the wedding kalo dia gampang emosi dengan hal-hal sepele.';

    final posts = _getProfilePosts(username, avatarUrl);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Gradasi warna latar belakang resmi Qcumber (#FFFFFF ke #AED09B)
        decoration: const BoxDecoration(
          gradient: QcumberColors.pageBackgroundGradient,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Cover Photo Banner & Avatar/Nama Header (Presisi Sesuai Foto Kedua)
              _buildCoverAndHeader(
                context,
                coverUrl,
                avatarUrl,
                username,
                handle,
              ),

              // 2. Kontainer Kartu Profil Putih dengan Sudut Lengkung
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bio Deskripsi
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Text(
                        bio,
                        style: GoogleFonts.poppins(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF536947),
                          height: 1.45,
                        ),
                      ),
                    ),

                    // Statistik Pengikut & Diikuti
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                      child: Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '$followers ',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF165540),
                                  ),
                                ),
                                TextSpan(
                                  text: 'Pengikut',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF536947),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '$following ',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF165540),
                                  ),
                                ),
                                TextSpan(
                                  text: 'Diikuti',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF536947),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Dua Tombol Aksi: "Pesan" & "Ikuti" (Menggantikan Edit Profil & Bagikan Profil)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                      child: Row(
                        children: [
                          // Tombol "Pesan" (Outline hijau sage berlatar putih)
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: OutlinedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Kirim pesan ke $username'),
                                      backgroundColor: const Color(0xFF165540),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(
                                    color: Color(0xFF82A86C),
                                    width: 1.4,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Pesan',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF165540),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Tombol "Ikuti" / "Mengikuti" (Solid hijau tua #165540 interaktif)
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _isFollowing = !_isFollowing;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        _isFollowing
                                            ? 'Sekarang Anda mengikuti $username'
                                            : 'Batal mengikuti $username',
                                      ),
                                      backgroundColor: const Color(0xFF165540),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isFollowing
                                      ? const Color(0xFFE5EFE2)
                                      : const Color(0xFF165540),
                                  foregroundColor: _isFollowing
                                      ? const Color(0xFF165540)
                                      : Colors.white,
                                  side: _isFollowing
                                      ? const BorderSide(
                                          color: Color(0xFF82A86C),
                                          width: 1.4,
                                        )
                                      : BorderSide.none,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  _isFollowing ? 'Mengikuti' : 'Ikuti',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 6),

              // 3. KARTU CAPTION / QUOTE PERTAMA ("stop the wedding...") Sesuai Permintaan Pengguna
              _buildQuoteCard(
                context: context,
                username: username,
                handle: handle,
                avatarUrl: avatarUrl,
                quote: postQuote,
                timeAgo: '2 jam',
                repliesCount: '745',
                retweetsCount: '1,8 rb',
                likeCount: _quote1LikeCount,
                isLiked: _isQuote1Liked,
                isSaved: _isQuote1Saved,
                savedCount: '1,1k',
                onLikeTap: () {
                  setState(() {
                    _isQuote1Liked = !_isQuote1Liked;
                    if (_isQuote1Liked) {
                      _quote1LikeCount += 1000;
                    } else {
                      _quote1LikeCount -= 1000;
                    }
                  });
                },
                onSaveTap: () {
                  setState(() {
                    _isQuote1Saved = !_isQuote1Saved;
                  });
                },
              ),

              // 4. Postingan Foto Pertama (Gedung Manhattan dengan Lekukan Notched Photo)
              if (posts.isNotEmpty)
                PostCard(
                  post: posts[0],
                  onCommentTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Komentar pada postingan ${posts[0].username}',
                        ),
                        backgroundColor: const Color(0xFF165540),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),

              // 5. KARTU CAPTION / QUOTE KEDUA (Variasi Caption Indah Kehidupan)
              _buildQuoteCard(
                context: context,
                username: username,
                handle: handle,
                avatarUrl: avatarUrl,
                quote: 'Kadang hal-hal sederhana adalah yang paling bermakna dalam hidup. Nikmati setiap potongan momen segar hari ini.',
                timeAgo: '8 jam',
                repliesCount: '412',
                retweetsCount: '980',
                likeCount: _quote2LikeCount,
                isLiked: _isQuote2Liked,
                isSaved: _isQuote2Saved,
                savedCount: '640',
                onLikeTap: () {
                  setState(() {
                    _isQuote2Liked = !_isQuote2Liked;
                    if (_isQuote2Liked) {
                      _quote2LikeCount += 1000;
                    } else {
                      _quote2LikeCount -= 1000;
                    }
                  });
                },
                onSaveTap: () {
                  setState(() {
                    _isQuote2Saved = !_isQuote2Saved;
                  });
                },
              ),

              // 6. Postingan-Postingan Foto Lainnya
              ...posts
                  .skip(1)
                  .map(
                    (post) => PostCard(
                      post: post,
                      onCommentTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Komentar pada postingan ${post.username}',
                            ),
                            backgroundColor: const Color(0xFF165540),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),

              // Ruang bawah agar postingan terakhir tidak tertutup navigation bar
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  /// Membangun Header Atas dengan Cover Photo dan Avatar/Nama Berdampingan (Mencegah Tabrakan)
  Widget _buildCoverAndHeader(
    BuildContext context,
    String coverUrl,
    String avatarUrl,
    String username,
    String handle,
  ) {
    return SizedBox(
      height: 240,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. Cover Photo (Park Ave / Arsitektur Monokrom)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 185,
            child: Image.asset(
              coverUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: const Color(0xFF222B27)),
            ),
          ),

          // 2. Gradien lembut di atas cover foto
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 185,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.45),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // 3. Baris Navigasi Atas (Tombol Back atau Judul "My Profile")
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            right: 16,
            child: Row(
              children: [
                if (widget.showBackButton)
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.35),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  )
                else
                  Text(
                    'My Profile',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      shadows: const [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black54,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                const Spacer(),
              ],
            ),
          ),

          // 4. Latar Belakang Kartu Putih Melengkung (Mulai di Y = 175)
          Positioned(
            top: 175,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
            ),
          ),

          // 5. Baris Avatar & Nama (Berdampingan secara horizontal, 100% BEBAS TABRAKAN)
          Positioned(
            left: 20,
            right: 20,
            bottom: 6,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Avatar Bulat Besar dengan Border Putih Tebal
                Container(
                  width: 92,
                  height: 92,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.14),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      avatarUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: const Color(0xFFC0D5B5),
                        child: const Icon(
                          Icons.person,
                          size: 48,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Nama Pengguna & Handle di sebelah kanan Avatar (Tidak saling bertumpuk)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          username,
                          style: GoogleFonts.poppins(
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF165540),
                            height: 1.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          handle,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF2C7769),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Membangun Kartu Postingan Quote / Caption (Sesuai Screenshot "stop the wedding...")
  Widget _buildQuoteCard({
    required BuildContext context,
    required String username,
    required String handle,
    required String avatarUrl,
    required String quote,
    required String timeAgo,
    required String repliesCount,
    required String retweetsCount,
    required int likeCount,
    required bool isLiked,
    required bool isSaved,
    required String savedCount,
    required VoidCallback onLikeTap,
    required VoidCallback onSaveTap,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8EFE5), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Postingan: Avatar, Nama, Badge Verified, Handle, Waktu, Menu
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipOval(
                  child: Image.asset(
                    avatarUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.person, size: 28),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      username,
                      style: GoogleFonts.poppins(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF165540),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.check_circle_rounded,
                      size: 15,
                      color: Color(0xFF1D9BF0),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        '$handle · $timeAgo',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF657786),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.more_horiz_rounded,
                color: Color(0xFF657786),
                size: 20,
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Kotak Quote / Caption Tengah (Sesuai Screenshot: "stop the wedding...")
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 22),
            decoration: BoxDecoration(
              color: const Color(0xFFFCFDFB),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE8EFE5), width: 1.2),
            ),
            child: Column(
              children: [
                Text(
                  quote,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(
                      0xFF6B7240,
                    ), // Warna teks zaitun quote sesuai screenshot
                    height: 1.5,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '~$username',
                    style: GoogleFonts.caveat(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF8A9352),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Baris Ikon Interaksi (Reply, Retweet, Like, Bookmark, Share)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 1. Reply
                _buildMetricIcon(
                  icon: Icons.chat_bubble_outline_rounded,
                  count: repliesCount,
                  color: const Color(0xFF657786),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Buka balasan postingan $username'),
                        backgroundColor: const Color(0xFF165540),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),

                // 2. Retweet
                _buildMetricIcon(
                  icon: Icons.repeat_rounded,
                  count: retweetsCount,
                  color: const Color(0xFF657786),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Retweet kutipan'),
                        backgroundColor: Color(0xFF165540),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),

                // 3. Like (Toggleable)
                _buildMetricIcon(
                  icon: isLiked
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  count: '${(likeCount / 1000).toStringAsFixed(0)} rb',
                  color: isLiked ? Colors.redAccent : const Color(0xFF657786),
                  onTap: onLikeTap,
                ),

                // 4. Bookmark (Toggleable)
                _buildMetricIcon(
                  icon: isSaved
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  count: savedCount,
                  color: isSaved
                      ? const Color(0xFF165540)
                      : const Color(0xFF657786),
                  onTap: onSaveTap,
                ),

                // 5. Share
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.share_outlined,
                    size: 19,
                    color: Color(0xFF657786),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Bagikan postingan'),
                        backgroundColor: Color(0xFF165540),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper untuk membangun metrik interaksi (ikon + teks angka)
  Widget _buildMetricIcon({
    required IconData icon,
    required String count,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 5),
          Text(
            count,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
