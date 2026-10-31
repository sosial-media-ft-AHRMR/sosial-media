import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/story_item.dart';

/// Halaman Penampil Story Layar Penuh (Story Viewer)
/// Sesuai 99% dengan Desain Figma Story.png & Story 2.png:
/// - Mendukung multi-slide per akun (Your.Idol memiliki 2 slide: Slide 1 salju malam & Slide 2 siluet bintang)
/// - Bilah kemajuan ganda (progress bar segments) di bagian atas:
///   * Segmen aktif: beranimasi putih (#FFFFFF)
///   * Segmen yang sudah selesai: berwarna hijau mentimun/sage (#82A86C) sesuai Story 2.png
///   * Segmen yang belum dilihat: putih transparan (35% opacity)
/// - Header profil: avatar lingkaran, nama "Your.Idol", dan lencana centang hijau verified (Icons.verified)
/// - Tanpa tombol 'X' silang di header (sesuai persis dengan desain asli Figma Story.png & Story 2.png)
/// - Navigasi interaktif: ketuk kanan untuk maju, ketuk kiri untuk mundur, tahan untuk jeda (pause)
/// - Swipe ke bawah (drag down) untuk menutup cerita
/// - Bilah bawah: wadah hijau sangat gelap (#102617), kolom input "Kirim Pesan.." melengkung stadium dengan border hijau pastel (#C7E39F), dan ikon hati (like) interaktif
class StoryViewerPage extends StatefulWidget {
  final StoryItem story;

  const StoryViewerPage({
    super.key,
    required this.story,
  });

  @override
  State<StoryViewerPage> createState() => _StoryViewerPageState();
}

class _StoryViewerPageState extends State<StoryViewerPage>
    with SingleTickerProviderStateMixin {
  late List<String> _slides;
  int _currentSlideIndex = 0;

  late AnimationController _progressController;
  final TextEditingController _replyController = TextEditingController();
  final FocusNode _replyFocusNode = FocusNode();

  bool _isLiked = false;
  bool _isPaused = false;

  // Durasi per slide cerita (5 detik)
  static const Duration _slideDuration = Duration(seconds: 5);

  static const Color _bottomBarBg = Color(0xFF102617);
  static const Color _accentGreenBorder = Color(0xFFC7E39F);
  static const Color _hintTextColor = Color(0xFFDEEBCE);
  static const Color _completedSegmentGreen = Color(0xFF82A86C);

  @override
  void initState() {
    super.initState();
    _slides = widget.story.effectiveSlides;

    _progressController = AnimationController(
      vsync: this,
      duration: _slideDuration,
    );

    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _onSlideCompleted();
      }
    });

    // Jeda otomatis jika pengguna sedang mengetik balasan cerita
    _replyFocusNode.addListener(() {
      if (_replyFocusNode.hasFocus) {
        _pauseStory();
      } else {
        _resumeStory();
      }
    });

    _progressController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _replyController.dispose();
    _replyFocusNode.dispose();
    super.dispose();
  }

  void _onSlideCompleted() {
    if (_currentSlideIndex < _slides.length - 1) {
      setState(() {
        _currentSlideIndex++;
      });
      _progressController.reset();
      _progressController.forward();
    } else {
      // Selesai seluruh slide dalam cerita ini
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  void _pauseStory() {
    if (!_isPaused) {
      _isPaused = true;
      _progressController.stop();
    }
  }

  void _resumeStory() {
    if (_isPaused && !_replyFocusNode.hasFocus) {
      _isPaused = false;
      _progressController.forward();
    }
  }

  void _goToPreviousSlide() {
    if (_currentSlideIndex > 0) {
      setState(() {
        _currentSlideIndex--;
      });
      _progressController.reset();
      _progressController.forward();
    } else {
      // Jika di slide pertama, ulangi dari awal slide 0
      _progressController.reset();
      _progressController.forward();
    }
  }

  void _goToNextSlide() {
    if (_currentSlideIndex < _slides.length - 1) {
      setState(() {
        _currentSlideIndex++;
      });
      _progressController.reset();
      _progressController.forward();
    } else {
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  void _sendMessage() {
    final text = _replyController.text.trim();
    if (text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Pesan terkirim ke ${widget.story.username}',
            style: GoogleFonts.poppins(fontSize: 13, color: Colors.white),
          ),
          backgroundColor: const Color(0xFF165540),
          duration: const Duration(seconds: 1),
        ),
      );
      _replyController.clear();
      _replyFocusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final story = widget.story;
    final String currentSlideAsset = _slides[_currentSlideIndex];
    final String avatarUrl = story.userAvatarUrl ??
        (story.imageUrl.isNotEmpty
            ? story.imageUrl
            : 'assets/feed/avatar_your_idol.png');

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: SizedBox.expand(
        child: GestureDetector(
          onVerticalDragEnd: (details) {
            // Swipe ke bawah untuk menutup cerita
            if ((details.primaryVelocity ?? 0) > 200) {
              Navigator.pop(context);
            }
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 1. Gambar Slide Cerita Layar Penuh
              Positioned.fill(
                child: _buildSlideImage(currentSlideAsset),
              ),

              // 2. Area Deteksi Sentuhan Layar (Kiri = Mundur, Kanan = Maju, Tahan = Pause)
              Positioned.fill(
                child: Row(
                  children: [
                    // Area Kiri (30% lebar layar)
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: _goToPreviousSlide,
                        onLongPressStart: (_) => _pauseStory(),
                        onLongPressEnd: (_) => _resumeStory(),
                      ),
                    ),
                    // Area Kanan (70% lebar layar)
                    Expanded(
                      flex: 7,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: _goToNextSlide,
                        onLongPressStart: (_) => _pauseStory(),
                        onLongPressEnd: (_) => _resumeStory(),
                      ),
                    ),
                  ],
                ),
              ),

              // 3. Bilah Atas: Indikator Segmen Progres & Header Pengguna Sesuai Figma
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 10.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Segmen Bar Kemajuan (Sesuai 99% dengan Story.png & Story 2.png)
                        AnimatedBuilder(
                          animation: _progressController,
                          builder: (context, child) {
                            return Row(
                              children: List.generate(_slides.length, (index) {
                                return Expanded(
                                  child: Container(
                                    height: 2.5,
                                    margin: EdgeInsets.only(
                                      right: index < _slides.length - 1 ? 8.0 : 0.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.35),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        double fillFraction = 0.0;
                                        Color fillColor = Colors.white;

                                        if (index < _currentSlideIndex) {
                                          // Slide sebelumnya: Hijau mentimun (#82A86C) sesuai Story 2.png
                                          fillFraction = 1.0;
                                          fillColor = _completedSegmentGreen;
                                        } else if (index == _currentSlideIndex) {
                                          // Slide aktif: Berjalan putih
                                          fillFraction = _progressController.value;
                                          fillColor = Colors.white;
                                        } else {
                                          fillFraction = 0.0;
                                        }

                                        return Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: constraints.maxWidth * fillFraction,
                                            decoration: BoxDecoration(
                                              color: fillColor,
                                              borderRadius: BorderRadius.circular(2),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        ),

                        const SizedBox(height: 14),

                        // Header Akun Story: Avatar, Nama, Lencana Centang Hijau (Tanpa Tombol X)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Row(
                            children: [
                              // Avatar Bulat dengan Border Putih Halus
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                ),
                                child: ClipOval(
                                  child: _buildAvatar(avatarUrl),
                                ),
                              ),

                              const SizedBox(width: 12),

                              // Nama Pengguna ("Your.Idol" dsb)
                              Text(
                                story.username,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.2,
                                ),
                              ),

                              // Lencana Centang Hijau Verified Sesuai Figma
                              if (story.isVerified) ...[
                                const SizedBox(width: 7),
                                const Icon(
                                  Icons.verified,
                                  color: Color(0xFF6DA260),
                                  size: 19,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 4. Bilah Aksi Bawah: Kotak "Kirim Pesan.." & Ikon Hati Like
            // Latar belakang solid #102617 sesuai 100% Figma Story.png & Story 2.png
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: _bottomBarBg,
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 14,
                  bottom: MediaQuery.of(context).padding.bottom > 0
                      ? MediaQuery.of(context).padding.bottom + 10
                      : 20,
                ),
                child: Row(
                  children: [
                    // Kolom Input Melengkung "Kirim Pesan.." Sesuai Figma
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: _accentGreenBorder,
                            width: 1.2,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Center(
                          child: TextField(
                            controller: _replyController,
                            focusNode: _replyFocusNode,
                            cursorColor: _accentGreenBorder,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 14.5,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Kirim Pesan..',
                              hintStyle: GoogleFonts.poppins(
                                color: _hintTextColor.withValues(alpha: 0.9),
                                fontSize: 14.5,
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onSubmitted: (_) => _sendMessage(),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 14),

                    // Ikon Hati Like Interaktif Presisi Figma
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isLiked = !_isLiked;
                        });
                      },
                      child: Container(
                        width: 44,
                        height: 44,
                        alignment: Alignment.center,
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 180),
                          scale: _isLiked ? 1.25 : 1.0,
                          child: Icon(
                            _isLiked
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: _isLiked
                                ? Colors.redAccent
                                : _accentGreenBorder,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
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

  Widget _buildSlideImage(String path) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        errorBuilder: (context, error, stackTrace) {
          // Fallback ke story_snow_bg.png
          return Image.asset(
            'assets/feed/story_snow_bg.png',
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            errorBuilder: (context, error, stackTrace) => Container(
              color: const Color(0xFF0F1E17),
              child: const Center(
                child: Icon(Icons.broken_image_rounded,
                    color: Colors.white54, size: 64),
              ),
            ),
          );
        },
      );
    } else {
      return Image.file(
        File(path),
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        errorBuilder: (context, error, stackTrace) => Container(
          color: const Color(0xFF0F1E17),
          child: const Center(
            child: Icon(Icons.broken_image_rounded,
                color: Colors.white54, size: 64),
          ),
        ),
      );
    }
  }

  Widget _buildAvatar(String path) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: const Color(0xFF165540),
          child: const Icon(Icons.person, color: Colors.white, size: 24),
        ),
      );
    } else {
      return Image.file(
        File(path),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: const Color(0xFF165540),
          child: const Icon(Icons.person, color: Colors.white, size: 24),
        ),
      );
    }
  }
}
