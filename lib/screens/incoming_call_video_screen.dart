import 'package:flutter/material.dart';
import 'package:sosial_media/screens/call_room_video_screen.dart';
import 'package:sosial_media/widgets/phone_frame.dart';

class IncomingCallVideoScreen extends StatelessWidget {
  final String callerName;
  final String callerAvatar;

  const IncomingCallVideoScreen({
    super.key,
    this.callerName = 'shawn',
    this.callerAvatar = 'assets/images/Shawn PP.jpg',
  });

  void _declineCall(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _acceptCall(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CallRoomVideoScreen(
          callerName: callerName,
          callerAvatar: callerAvatar,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PhoneFrame(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            // 1. Gambar Background Kamera Video Lokal Sesuai Figma
            Image.asset(
              'assets/images/video_caller_preview.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFF1E293B),
                  child: const Center(
                    child: Icon(
                      Icons.videocam_outlined,
                      color: Colors.white24,
                      size: 90,
                    ),
                  ),
                );
              },
            ),

            // 2. Gradient Overlay Halus untuk Kontras Elemen UI
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.55),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.65),
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),

            // 3. Konten Utama
            SafeArea(
              child: Stack(
                children: [
                  // Tombol Kembali '<' di Kiri Atas
                  Positioned(
                    left: 12,
                    top: 12,
                    child: IconButton(
                      icon: const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 36,
                      ),
                      onPressed: () => _declineCall(context),
                    ),
                  ),

                  // Info Pemanggil Video di Tengah Layar
                  Align(
                    alignment: const Alignment(0, -0.15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 250,
                          height: 250,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Colors.white.withValues(alpha: 0.35),
                                Colors.white.withValues(alpha: 0.12),
                                Colors.transparent,
                              ],
                              stops: const [0.45, 0.75, 1.0],
                            ),
                          ),
                          child: Container(
                            width: 172,
                            height: 172,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.5),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                callerAvatar,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: const Color(0xFF1B4D3E),
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 80,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Nama Pemanggil
                        Text(
                          callerName,
                          style: const TextStyle(
                            fontFamily: 'sans-serif',
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: -0.3,
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Keterangan Panggilan Video Masuk
                        const Text(
                          'Panggilan Video Masuk',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Tombol Aksi Panggilan Video di Bagian Bawah
                  Positioned(
                    left: 48,
                    right: 48,
                    bottom: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => _declineCall(context),
                          child: Container(
                            width: 72,
                            height: 72,
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

                        GestureDetector(
                          onTap: () => _acceptCall(context),
                          child: Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF22C55E),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF22C55E).withValues(alpha: 0.5),
                                  blurRadius: 14,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.call,
                              color: Colors.white,
                              size: 36,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
