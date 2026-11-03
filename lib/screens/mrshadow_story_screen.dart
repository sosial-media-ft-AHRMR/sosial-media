import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/qcumber_colors.dart';

/// Model internal untuk tiap slide dalam cerita MrShadow
class _MrShadowSlide {
  final String imagePath;
  final String caption;
  final String location;
  final String musicTrack;
  final String timeAgo;

  const _MrShadowSlide({
    required this.imagePath,
    required this.caption,
    required this.location,
    required this.musicTrack,
    required this.timeAgo,
  });
}

/// Layar Cerita Khusus MrShadow (MrShadow Story Screen)
/// Tampilan Fullscreen Imersif dengan tema estetika Qcumber
class MrShadowStoryScreen extends StatefulWidget {
  const MrShadowStoryScreen({super.key});

  @override
  State<MrShadowStoryScreen> createState() => _MrShadowStoryScreenState();
}

class _MrShadowStoryScreenState extends State<MrShadowStoryScreen>
    with SingleTickerProviderStateMixin {
  // 3 Slide cerita estetik MrShadow
  final List<_MrShadowSlide> _slides = const [
    _MrShadowSlide(
      imagePath: 'assets/feed/story_mrshadow.png',
      caption: 'Embrace the shadows, find the rhythm within the quiet night 🌙✨',
      location: '📍 Tokyo Underground',
      musicTrack: '🎵 Midnight City — M83',
      timeAgo: '2 jam yang lalu',
    ),
    _MrShadowSlide(
      imagePath: 'assets/feed/post_amsterdam.png',
      caption: 'Wandering through neon mist & glowing streetlamps 🌧️🏙️',
      location: '📍 Amsterdam Canal District',
      musicTrack: '🎵 After Dark — Mr. Kitty',
      timeAgo: '4 jam yang lalu',
    ),
    _MrShadowSlide(
      imagePath: 'assets/feed/story_stars_bg.png',
      caption: 'Under a billion stars, listening to the universe breathe 🌌',
      location: '📍 Stargazer Valley',
      musicTrack: '🎵 Starboy — Kygo Remix',
      timeAgo: '6 jam yang lalu',
    ),
  ];

  int _currentIndex = 0;
  late AnimationController _progressController;
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _isLiked = false;
  bool _isPaused = false;
  static const Duration _slideDuration = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: _slideDuration,
    );

    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _goToNextSlide();
      }
    });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _pauseTimer();
      } else {
        _resumeTimer();
      }
    });

    _progressController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _messageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _pauseTimer() {
    if (!_isPaused) {
      _isPaused = true;
      _progressController.stop();
    }
  }

  void _resumeTimer() {
    if (_isPaused && !_focusNode.hasFocus) {
      _isPaused = false;
      _progressController.forward();
    }
  }

  void _goToNextSlide() {
    if (_currentIndex < _slides.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _progressController.reset();
      _progressController.forward();
    } else {
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  void _goToPreviousSlide() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _progressController.reset();
      _progressController.forward();
    } else {
      _progressController.reset();
      _progressController.forward();
    }
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    _messageController.clear();
    _focusNode.unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: QcumberColors.limeGreen),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Pesan terkirim ke MrShadow: "$text"',
                style: GoogleFonts.poppins(fontSize: 13, color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF102617),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showOptionsSheet() {
    _pauseTimer();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF16251C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.share_outlined, color: Colors.white),
                  title: Text(
                    'Bagikan Cerita Ini',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Tautan disalin ke clipboard!')),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.volume_mute_outlined, color: Colors.white),
                  title: Text(
                    'Bisukan Cerita @mrshadow',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.flag_outlined, color: Colors.redAccent),
                  title: Text(
                    'Laporkan Cerita Ini',
                    style: GoogleFonts.poppins(color: Colors.redAccent),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                  },
                ),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      _resumeTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentSlide = _slides[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onLongPressStart: (_) => _pauseTimer(),
        onLongPressEnd: (_) => _resumeTimer(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 1. Gambar Konten Story (Full Cover)
            Image.asset(
              currentSlide.imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF0D1F17),
                        Color(0xFF165540),
                        Color(0xFF0A130E),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.nightlight_round,
                          size: 72,
                          color: QcumberColors.limeGreen,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'MrShadow Visual',
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // 2. Lapisan Gradien Transparan Atas & Bawah
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.25, 0.65, 1.0],
                    colors: [
                      Colors.black.withValues(alpha: 0.75),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.35),
                      Colors.black.withValues(alpha: 0.90),
                    ],
                  ),
                ),
              ),
            ),

            // 3. Sensor Ketuk Kiri (Prev) & Kanan (Next)
            Positioned.fill(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: _goToPreviousSlide,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: _goToNextSlide,
                    ),
                  ),
                ],
              ),
            ),

            // 4. Area Header: Progress Bars & Info Pengguna
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress Bars Segmen Atas
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    child: Row(
                      children: List.generate(_slides.length, (index) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.5),
                            child: AnimatedBuilder(
                              animation: _progressController,
                              builder: (context, child) {
                                double value = 0.0;
                                if (index < _currentIndex) {
                                  value = 1.0;
                                } else if (index == _currentIndex) {
                                  value = _progressController.value;
                                }
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: value,
                                    minHeight: 3.5,
                                    backgroundColor: Colors.white30,
                                    valueColor: const AlwaysStoppedAnimation<Color>(
                                      QcumberColors.limeGreen,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  // Header Profil MrShadow & Tombol Aksi
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Row(
                      children: [
                        // Avatar Berbingkai Gradien Qcumber
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                QcumberColors.primaryGreen,
                                QcumberColors.limeGreen,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: QcumberColors.limeGreen.withValues(alpha: 0.4),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage('assets/feed/avatar_mrshadow.png'),
                          ),
                        ),
                        const SizedBox(width: 10),

                        // Nama dan Waktu
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'MrShadow',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.verified,
                                    size: 15,
                                    color: QcumberColors.limeGreen,
                                  ),
                                ],
                              ),
                              Text(
                                currentSlide.timeAgo,
                                style: GoogleFonts.poppins(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Tombol Opsi (...)
                        IconButton(
                          icon: const Icon(Icons.more_vert, color: Colors.white),
                          onPressed: _showOptionsSheet,
                        ),

                        // Tombol Close (X)
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white24, width: 1),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.close, size: 20, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Stiker Lokasi & Musik
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        // Chip Lokasi
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: QcumberColors.limeGreen.withValues(alpha: 0.6),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            currentSlide.location,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // Chip Musik
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white24,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            currentSlide.musicTrack,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 5. Area Tengah Bawah: Teks Caption Cerita
            Positioned(
              left: 20,
              right: 20,
              bottom: 105,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                ),
                child: Text(
                  currentSlide.caption,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      const Shadow(
                        blurRadius: 8,
                        color: Colors.black87,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 6. Bilah Bawah (Bottom Action Bar): Balas Pesan & Like
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 12,
                  bottom: MediaQuery.of(context).padding.bottom + 12,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFF102617),
                  border: Border(
                    top: BorderSide(color: Color(0xFF1D3B27), width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    // Field Input Pesan Balasan
                    Expanded(
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B3824),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: QcumberColors.limeGreen,
                            width: 1.2,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _messageController,
                                focusNode: _focusNode,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Kirim pesan ke MrShadow...',
                                  hintStyle: GoogleFonts.poppins(
                                    color: const Color(0xFFDEEBCE).withValues(alpha: 0.7),
                                    fontSize: 12,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                onSubmitted: (_) => _sendMessage(),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.send_rounded,
                                size: 18,
                                color: QcumberColors.limeGreen,
                              ),
                              onPressed: _sendMessage,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Tombol Like (Hati Beranimasi)
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isLiked = !_isLiked;
                        });
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isLiked
                              ? Colors.red.withValues(alpha: 0.2)
                              : const Color(0xFF1B3824),
                          border: Border.all(
                            color: _isLiked ? Colors.redAccent : Colors.white24,
                            width: 1.2,
                          ),
                        ),
                        child: Icon(
                          _isLiked ? Icons.favorite : Icons.favorite_border_rounded,
                          color: _isLiked ? Colors.redAccent : Colors.white,
                          size: 24,
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
    );
  }
}
