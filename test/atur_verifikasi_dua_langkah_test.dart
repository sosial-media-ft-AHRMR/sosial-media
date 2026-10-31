import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sosial_media/atur_verifikasi_dua_langkah/atur_verifikasi_dua_langkah.dart';
import 'package:sosial_media/lupa_sandi/lupa_sandi.dart';
import 'package:sosial_media/widgets/popups/two_factor_success_dialog.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Modul Atur Verifikasi Dua Langkah Tests', () {
    testWidgets('1. AturVerifikasiDuaLangkahPage renders all components correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AturVerifikasiDuaLangkahPage(),
        ),
      );
      await tester.pump();

      // Check header and content
      expect(find.text('Verifikasi Dua Langkah'), findsNWidgets(2)); // header & title
      expect(
        find.text(
          'Anda dapat mengatur kata sandi kedua\nyang akan digunakan ketika anda login\nmelalui perangkat baru.',
        ),
        findsOneWidget,
      );
      expect(find.text('Atur Verifikasi Dua Langkah'), findsOneWidget);

      // Check lock icon graphic
      final imageFinder = find.byWidgetPredicate((widget) =>
          widget is Image &&
          widget.image is AssetImage &&
          (widget.image as AssetImage).assetName ==
              'assets/feed/icon_two_factor_lock.png');
      expect(imageFinder, findsOneWidget);
    });

    testWidgets('2. Tapping action button navigates to MasukkanKataSandiDuaLangkahPage',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AturVerifikasiDuaLangkahPage(),
        ),
      );
      await tester.pump();

      await tester.tap(find.text('Atur Verifikasi Dua Langkah'));
      await tester.pumpAndSettle();

      expect(find.byType(MasukkanKataSandiDuaLangkahPage), findsOneWidget);
      expect(
        find.text('Masukan kata sandi verifikasi yang\ntelah anda buat'),
        findsOneWidget,
      );
      expect(find.text('Lupa sandi?'), findsOneWidget);
      expect(find.text('Konfirmasi'), findsOneWidget);
    });

    testWidgets('3. MasukkanKataSandiDuaLangkahPage validates empty input and toggles visibility',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MasukkanKataSandiDuaLangkahPage(),
        ),
      );
      await tester.pump();

      // Tap Konfirmasi without password -> shows SnackBar
      await tester.tap(find.text('Konfirmasi'));
      await tester.pump(const Duration(milliseconds: 100));

      expect(
        find.text('Silakan masukkan kata sandi terlebih dahulu'),
        findsOneWidget,
      );

      // Clean up SnackBar
      ScaffoldMessenger.of(tester.element(find.text('Verifikasi Dua Langkah')))
          .hideCurrentSnackBar();
      await tester.pump(const Duration(milliseconds: 300));

      // Enter password
      await tester.enterText(find.byType(TextField), 'secret2fa');
      await tester.pump();

      // Toggle eye icon
      final eyeIconFinder = find.byType(IconButton).at(1); // second icon button (first is back button)
      await tester.tap(eyeIconFinder);
      await tester.pump();

      // Verify TextField obscureText changed
      final TextField textField = tester.widget(find.byType(TextField));
      expect(textField.obscureText, isFalse);
    });

    testWidgets('4. Tapping Lupa sandi? opens LupaPasswordPage',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MasukkanKataSandiDuaLangkahPage(),
        ),
      );
      await tester.pump();

      await tester.tap(find.text('Lupa sandi?'));
      await tester.pumpAndSettle();

      expect(find.byType(LupaPasswordPage), findsOneWidget);
    });

    testWidgets('5. Entering valid password and confirming displays success dialog',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MasukkanKataSandiDuaLangkahPage(),
        ),
      );
      await tester.pump();

      await tester.enterText(find.byType(TextField), 'mysecret123');
      await tester.pump();

      await tester.tap(find.text('Konfirmasi'));
      await tester.pumpAndSettle();

      // Verify TwoFactorSuccessDialog appears
      expect(find.byType(TwoFactorSuccessDialog), findsOneWidget);
      expect(
        find.text('Kata sandi verifikasi dua\nlangkah anda berhasil dibuat'),
        findsOneWidget,
      );
      expect(find.text('Lanjut'), findsOneWidget);

      // Tap Lanjut on dialog
      await tester.tap(find.text('Lanjut'));
      await tester.pumpAndSettle();

      // Dialog is dismissed
      expect(find.byType(TwoFactorSuccessDialog), findsNothing);
    });
  });
}

