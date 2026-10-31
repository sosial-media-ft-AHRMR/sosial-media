import 'package:flutter/material.dart';

import 'fitur pendukung/fitur_pendukung.dart';
import 'informasi_pribadi/informasi_pribadi_page.dart';
import 'laporkan_masalah/laporkan_masalah.dart';
import 'lupa_sandi/lupa_sandi.dart';
import 'main_scaffold.dart';
import 'pengaturan/pengaturan.dart';
import 'pusat bantuan/pusat_bantuan.dart';
import 'screens/call_room_audio_screen.dart';
import 'screens/call_room_video_screen.dart';
import 'screens/chat_list_screen.dart';
import 'screens/chat_room_screen.dart';
import 'screens/daftar_akun_screen.dart';
import 'screens/daftar_berhasil_screen.dart';
import 'screens/incoming_call_audio_screen.dart';
import 'screens/incoming_call_video_screen.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';
import 'ubah_sandi/ubah_sandi_page.dart';

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
      // Memulai aplikasi dari Splash Screen sesuai instruksi
      initialRoute: '/splash',
      routes: {
        // Alur Autentikasi & Masuk
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/daftar': (context) => const DaftarAkunScreen(),
        '/daftar_berhasil': (context) => const DaftarBerhasilScreen(),
        '/lupa-password': (context) => const LupaPasswordPage(),
        '/verifikasi-email': (context) => const VerifikasiEmailPage(identifier: ''),
        '/reset-password': (context) => const ResetPasswordPage(),

        // Beranda Utama & Feed Media Sosial
        '/feed': (context) => const MainScaffold(),

        // Komunikasi, Pesan & Panggilan
        '/chat_list': (context) => const ChatListScreen(),
        '/chat_room': (context) => const ChatRoomScreen(),
        '/incoming_call_audio': (context) => const IncomingCallAudioScreen(),
        '/call_room_audio': (context) => const CallRoomAudioScreen(),
        '/incoming_call_video': (context) => const IncomingCallVideoScreen(),
        '/call_room_video': (context) => const CallRoomVideoScreen(),

        // Fitur Pendukung & Pengaturan Akun
        '/disimpan': (context) => const DisimpanPage(),
        '/notifikasi': (context) => const NotifikasiPage(),
        '/pengaturan': (context) => const PengaturanPage(),
        '/informasi-pribadi': (context) => const InformasiPribadiPage(),
        '/akun-privat': (context) => const AkunPrivatPage(),
        '/status-aktivitas': (context) => const StatusAktivitasPage(),
        '/diblokir': (context) => const DiblokirPage(),
        '/penggunaan-data': (context) => const PenggunaanDataPage(),
        '/privasi-keamanan': (context) => const PrivasiKeamananPage(),
        '/tempat-login': (context) => const TempatLoginPage(),
        '/verifikasi-dua-langkah': (context) => const VerifikasiDuaLangkahPage(),
        '/verifikasi-kata-sandi': (context) => const VerifikasiKataSandiPage(),
        '/atur-verifikasi-dua-langkah': (context) => const AturVerifikasiDuaLangkahPage(),
        '/masukkan-kata-sandi-dua-langkah': (context) => const MasukkanKataSandiDuaLangkahPage(),
        '/ubah-sandi': (context) => const UbahSandiPage(),
        '/laporkan-masalah': (context) => const LaporkanMasalahPage(),
        '/pusat-bantuan': (context) => const PusatBantuanPage(),
      },
    );
  }
}
