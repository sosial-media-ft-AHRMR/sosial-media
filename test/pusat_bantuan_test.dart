import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sosial_media/main_scaffold.dart';
import 'package:sosial_media/pusat bantuan/pusat_bantuan.dart';

void main() {
  group('Pusat Bantuan Module Tests', () {
    testWidgets('PusatBantuanPage renders topics and searches correctly',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const MaterialApp(home: PusatBantuanPage()));

      expect(find.text('Pusat Bantuan'), findsOneWidget);
      expect(find.text('Privasi dan Keamanan'), findsOneWidget);
      expect(find.text('Verifikasi 2 Langkah'), findsOneWidget);
      expect(find.text('Akun Privat'), findsOneWidget);
      expect(find.text('Penggunaan Data'), findsOneWidget);
      expect(find.text('Status Aktivitas'), findsOneWidget);
      expect(find.text('Akun Diblokir'), findsOneWidget);

      // Search functionality
      await tester.enterText(find.byType(TextField), 'privat');
      await tester.pump();
      expect(find.text('Akun Privat'), findsOneWidget);
    });

    testWidgets('AkunPrivatHelpPage toggles switch', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AkunPrivatHelpPage()));
      expect(find.text('Akun Privat'), findsOneWidget);
      expect(find.text('Akun privat'), findsOneWidget);

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
    });

    testWidgets('DiblokirHelpPage renders blocked list', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: DiblokirHelpPage()));
      expect(find.text('Diblokir'), findsOneWidget);
      expect(find.text('Gisela Anastasia'), findsOneWidget);
    });

    testWidgets('PenggunaanDataHelpPage renders switches and options',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PenggunaanDataHelpPage()));
      expect(find.text('Penggunaan Data'), findsOneWidget);
      expect(find.text('Penghemat Data'), findsOneWidget);
      expect(find.text('Hanya Wi-Fi'), findsOneWidget);
    });

    testWidgets('PrivasiKeamananHelpPage renders sections', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PrivasiKeamananHelpPage()));
      expect(find.text('Privasi dan Keamanan'), findsOneWidget);
      expect(find.text('Kata Sandi'), findsOneWidget);
      expect(find.text('Verifikasi Dua Langkah'), findsOneWidget);
    });

    testWidgets('VerifikasiKataSandiHelpPage toggles obscure text',
        (tester) async {
      await tester.pumpWidget(
          const MaterialApp(home: VerifikasiKataSandiHelpPage()));
      expect(find.text('Verifikasi'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      await tester.tap(find.byType(IconButton).last);
      await tester.pump();
    });

    testWidgets('Opens PusatBantuanPage from PengaturanPage',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const MaterialApp(home: MainScaffold()));
      await tester.pumpAndSettle();

      // Open drawer
      final scaffoldState =
          tester.firstState<ScaffoldState>(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      expect(find.text('Pengaturan'), findsOneWidget);
      await tester.tap(find.text('Pengaturan'));
      await tester.pumpAndSettle();

      expect(find.text('Pusat Bantuan'), findsOneWidget);
      await tester.tap(find.text('Pusat Bantuan'));
      await tester.pumpAndSettle();

      expect(find.byType(PusatBantuanPage), findsOneWidget);
    });
  });
}
