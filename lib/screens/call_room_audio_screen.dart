import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sosial_media/screens/call_room_video_screen.dart';
import 'package:sosial_media/widgets/phone_frame.dart';

class CallRoomAudioScreen extends StatefulWidget {
  final String callerName;
  final String callerAvatar;

  const CallRoomAudioScreen({
    super.key,
    this.callerName = 'shawn',
    this.callerAvatar = 'assets/images/Shawn PP.jpg',
  });

  @override
  State<CallRoomAudioScreen> createState() => _CallRoomAudioScreenState();
}

class _CallRoomAudioScreenState extends State<CallRoomAudioScreen> {
  Timer? _callTimer;
  int _secondsElapsed = 1; // Mulai dari 00.01 sesuai tangkapan Figma
  bool _isMuted = false;
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
    return '$minutes.$seconds';
  }

  void _endCall() {
    _callTimer?.cancel();
    Navigator.of(context).pop();
  }

  void _switchToVideoCall() {
    _callTimer?.cancel();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CallRoomVideoScreen(
          callerName: widget.callerName,
          callerAvatar: widget.callerAvatar,
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
              // 1. Top Bar: Tombol Kembali '<' & Tombol Speaker
              Positioned(
                left: 12,
                top: 12,
                child: IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 36,
                  ),
                  onPressed: _endCall,
                ),
              ),
              Positioned(
                right: 20,
                top: 16,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSpeaker = !_isSpeaker;
                    });
                  },
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF222222),
                      border: Border.all(
                        color: _isSpeaker
                            ? Colors.white.withValues(alpha: 0.2)
                            : Colors.transparent,
                      ),
                    ),
                    child: Icon(
                      _isSpeaker ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              ),

              // 2. Info Pemanggil di Tengah
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
                            widget.callerAvatar,
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

                    Text(
                      widget.callerName,
                      style: const TextStyle(
                        fontFamily: 'sans-serif',
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      _formatCallDuration(_secondsElapsed),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),

              // 3. Kontrol Bawah: Tombol Video, Akhiri Panggilan, dan Mute
              Positioned(
                left: 32,
                right: 32,
                bottom: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _switchToVideoCall,
                      child: Container(
                        width: 58,
                        height: 58,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF222222),
                        ),
                        child: const Icon(
                          Icons.videocam_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: _endCall,
                      child: Container(
                        width: 76,
                        height: 76,
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF331414),
                        ),
                        child: Container(
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
                    ),

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isMuted = !_isMuted;
                        });
                      },
                      child: Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isMuted ? Colors.white24 : const Color(0xFF222222),
                        ),
                        child: Icon(
                          _isMuted ? Icons.mic_off_rounded : Icons.mic_none_rounded,
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
        ),
      ),
    );
  }
}
