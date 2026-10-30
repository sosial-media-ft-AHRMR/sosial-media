import 'package:flutter/material.dart';
import 'package:sosial_media/screens/call_room_audio_screen.dart';
import 'package:sosial_media/widgets/phone_frame.dart';

class IncomingCallAudioScreen extends StatelessWidget {
  final String callerName;
  final String callerAvatar;

  const IncomingCallAudioScreen({
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
            CallRoomAudioScreen(
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
        body: SafeArea(
          child: Stack(
            children: [
              // 1. Tombol Kembali '<' di Kiri Atas
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

              // 2. Info Pemanggil di Tengah (Avatar dengan Radial Glow & Teks)
              Align(
                alignment: Alignment.center,
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
                            Colors.white.withValues(alpha: 0.32),
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
                              color: Colors.black.withValues(alpha: 0.4),
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
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Keterangan Panggilan
                    const Text(
                      'Panggilan Masuk',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              // 3. Tombol Aksi Panggilan di Bagian Bawah
              Positioned(
                left: 48,
                right: 48,
                bottom: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tombol Tolak / Decline (Merah)
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
                              color: const Color(0xFFDE1F1F).withValues(alpha: 0.4),
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

                    // Tombol Terima / Accept (Hijau)
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
                              color: const Color(0xFF22C55E).withValues(alpha: 0.4),
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
      ),
    );
  }
}
