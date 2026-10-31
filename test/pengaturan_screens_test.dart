import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sosial_media/pengaturan/pengaturan.dart';

void main() {
  group('Pengaturan Screens Comprehensive Test', () {
    testWidgets('AkunPrivatPage renders and toggles switch', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AkunPrivatPage()));
      expect(find.text('Privasi Akun'), findsOneWidget);
      expect(find.text('Akun privat'), findsOneWidget);

      // Tap custom switch
      await tester.tap(find.text('Akun privat'));
      await tester.pumpAndSettle();
    });

    testWidgets('StatusAktivitasPage renders and toggles switch', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: StatusAktivitasPage()));
      expect(find.text('Status Aktivitas'), findsOneWidget);
      expect(find.text('Status online'), findsOneWidget);

      await tester.tap(find.text('Status online'));
      await tester.pumpAndSettle();
    });

    testWidgets('DiblokirPage unblocks user and shows empty state', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: DiblokirPage()));
      expect(find.text('Akun yang diblokir'), findsOneWidget);
      expect(find.text('William'), findsOneWidget);

      // Tap Berhenti Blokir
      await tester.tap(find.text('Berhenti Blokir'));
      await tester.pumpAndSettle();

      // Check empty state
      expect(find.text('Tidak ada akun yang diblokir'), findsOneWidget);
    });

    testWidgets('PenggunaanDataPage renders toggles and button', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PenggunaanDataPage()));
      expect(find.text('Penghemat Data'), findsOneWidget);
      expect(find.text('Simpan Perubahan'), findsOneWidget);
    });

    testWidgets('PrivasiKeamananPage navigates to sub screens', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PrivasiKeamananPage()));
      expect(find.text('Ubah kata sandi'), findsOneWidget);
      expect(find.text('Verifikasi dua langkah'), findsOneWidget);
      expect(find.text('Tempat anda login'), findsOneWidget);

      // Tap Tempat anda login
      await tester.tap(find.text('Tempat anda login'));
      await tester.pumpAndSettle();
      expect(find.byType(TempatLoginPage), findsOneWidget);
    });

    testWidgets('VerifikasiKataSandiPage toggles obscure text', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: VerifikasiKataSandiPage()));
      expect(find.text('Konfirmasi'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      // Toggle eye icon
      await tester.tap(find.byType(IconButton).last);
      await tester.pumpAndSettle();
    });
  });
}

