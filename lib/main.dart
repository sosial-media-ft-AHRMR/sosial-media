import 'package:flutter/material.dart';
import 'package:sosial_media/screens/splash_screen.dart';
import 'package:sosial_media/screens/login_screen.dart';
import 'package:sosial_media/screens/daftar_akun_screen.dart';
import 'package:sosial_media/screens/daftar_berhasil_screen.dart';
import 'package:sosial_media/screens/chat_list_screen.dart';
import 'package:sosial_media/screens/chat_room_screen.dart';
import 'package:sosial_media/screens/incoming_call_audio_screen.dart';
import 'package:sosial_media/screens/call_room_audio_screen.dart';
import 'package:sosial_media/screens/incoming_call_video_screen.dart';
import 'package:sosial_media/screens/call_room_video_screen.dart';

void main() {
  runApp(const QcumberApp());
}

class QcumberApp extends StatelessWidget {
  const QcumberApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qcumber - Media Sosial',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'sans-serif',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B4D3E),
          primary: const Color(0xFF1B4D3E),
          secondary: const Color(0xFF2B7853),
        ),
      ),
      // Langsung menampilkan Layar Chat List ("Komunikasi dan Pesan")
      initialRoute: '/chat_list',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/daftar': (context) => const DaftarAkunScreen(),
        '/daftar_berhasil': (context) => const DaftarBerhasilScreen(),
        '/chat_list': (context) => const ChatListScreen(),
        '/chat_room': (context) => const ChatRoomScreen(),
        '/incoming_call_audio': (context) => const IncomingCallAudioScreen(),
        '/call_room_audio': (context) => const CallRoomAudioScreen(),
        '/incoming_call_video': (context) => const IncomingCallVideoScreen(),
        '/call_room_video': (context) => const CallRoomVideoScreen(),
      },
    );
  }
}
