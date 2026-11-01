import 'dart:async';
import 'package:flutter/material.dart';

class CallRoomVideoScreen extends StatefulWidget {
  final String callerName;
  final String callerAvatar;

  const CallRoomVideoScreen({
    super.key,
    this.callerName = 'shawn',
    this.callerAvatar = 'assets/images/Shawn PP.jpg',
  });

  @override
  State<CallRoomVideoScreen> createState() => _CallRoomVideoScreenState();
}

class _CallRoomVideoScreenState extends State<CallRoomVideoScreen> {
  Timer? _callTimer;
  int _secondsElapsed = 1; // 00.01 sesuai Figma
  bool _isMuted = true; // Sesuai tangkapan Figma Call Room-1.png (mic off aktif)
  bool _isCameraOff = false;
  bool _isSpeaker = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _secondsElapsed++;
        });
      }
    });
  }

  @override
  void dispose() {
    _callTimer?.cancel();
    super.dispose();
  }

  String _formatCallDuration(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes.$seconds'; // Format dot '.' persis Figma 00.01
  }

  void _endCall() {
    _callTimer?.cancel();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Video Stream Bersih Lawan Bicara (Menggunakan Foto Bersih Shawn di Kafe Tanpa Tombol Screenshot)
          _isCameraOff
              ? Container(
                  color: const Color(0xFF111827),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            widget.callerAvatar,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.person, size: 80, color: Colors.white54),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Kamera Dimatikan',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                )
              : Image.asset(
                  "assets/images/Men's photo selfie.jpg", // Foto bersih asli Shawn di kafe tanpa tombol ganda
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/Shawn PP.jpg',
                      fit: BoxFit.cover,
                    );
                  },
                ),

          // 2. Gradient Overlay Halus Atas & Bawah agar Teks & Tombol Terlihat Jelas
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.55),
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.65),
                ],
                stops: const [0.0, 0.22, 0.75, 1.0],
              ),
            ),
          ),

          // 3. Floating Picture-in-Picture (PIP) Kamera Selfie Bersih Sesuai Figma Call Room-1.png
          Positioned(
            right: 18,
            top: 90,
            child: Container(
              width: 110,
              height: 155,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.85),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.45),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  'assets/images/video_self_pip.png', // Foto selfie bersih pengguna tanpa elemen UI ganda
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFF1E293B),
                      child: const Center(
                        child: Icon(Icons.person, color: Colors.white70, size: 36),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // 4. Header Bar Atas: Tombol Kembali '<', Nama & Durasi di Tengah, Speaker di Kanan
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 38,
                      ),
                      onPressed: _endCall,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.callerName,
                            style: const TextStyle(
                              fontFamily: 'sans-serif',
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.2,
                              shadows: [
                                Shadow(
                                  color: Colors.black87,
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _formatCallDuration(_secondsElapsed),
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              shadows: [
                                Shadow(
                                  color: Colors.black87,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSpeaker = !_isSpeaker;
                        });
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF1E1E1E),
                          border: Border.all(
                            color: _isSpeaker
                                ? Colors.white.withValues(alpha: 0.2)
                                : Colors.transparent,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          _isSpeaker
                              ? Icons.volume_up_rounded
                              : Icons.volume_off_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 5. Kontrol Bawah: Kamera On/Off, Akhiri Panggilan, dan Mute Mikrofon
          Positioned(
            left: 32,
            right: 32,
            bottom: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Tombol Kamera On / Off
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isCameraOff = !_isCameraOff;
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isCameraOff
                          ? Colors.white24
                          : const Color(0xFF1E1E1E),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(
                      _isCameraOff
                          ? Icons.videocam_off_rounded
                          : Icons.videocam_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),

                // Tombol Akhiri Panggilan (Merah Sesuai Figma)
                GestureDetector(
                  onTap: _endCall,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 82,
                    height: 82,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF2E1212), // Halo gelap luar
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFDE1F1F),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFDE1F1F).withValues(alpha: 0.5),
                            blurRadius: 14,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.call_end,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                ),

                // Tombol Mute Mikrofon
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isMuted = !_isMuted;
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isMuted
                          ? const Color(0xFF2A2A2A)
                          : const Color(0xFF1E1E1E),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(
                      _isMuted ? Icons.mic_off_rounded : Icons.mic_rounded,
                      color: Colors.white,
                      size: 28,
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
}
