import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sosial_media/lupa_sandi/lupa_sandi.dart';
import 'package:sosial_media/tampilan_utama/login_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Modul Lupa Sandi Tests', () {
    testWidgets('1. LupaPasswordPage renders correctly and validates empty input',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LupaPasswordPage(),
        ),
      );
      await tester.pump();

      // Check header
      expect(find.text('Lupa password'), findsOneWidget);
      expect(find.text('Alamat email'), findsOneWidget);
      expect(find.text('Coba cara lain'), findsOneWidget);
      expect(find.text('Kirim'), findsOneWidget);

      // Tap Kirim with empty field -> triggers validation SnackBar
      await tester.tap(find.text('Kirim'));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Harap masukkan alamat email anda'), findsOneWidget);

      // Clean up SnackBar
      ScaffoldMessenger.of(tester.element(find.text('Lupa password')))
          .hideCurrentSnackBar();
      await tester.pump(const Duration(milliseconds: 300));
    });

    testWidgets('2. LupaPasswordPage toggles between email and phone mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LupaPasswordPage(),
        ),
      );
      await tester.pump();

      expect(find.text('Alamat email'), findsOneWidget);

      // Tap "Coba cara lain"
      await tester.tap(find.text('Coba cara lain'));
      await tester.pump();

      // Mode changes to Nomor Handphone
      expect(find.text('Nomor Handphone'), findsOneWidget);
      expect(find.text('Silahkan masukkan nomor handphone anda untuk menerima nomor verifikasi.'), findsOneWidget);

      // Tap "Coba cara lain" again
      await tester.tap(find.text('Coba cara lain'));
      await tester.pump();

      // Reverts to Alamat email
      expect(find.text('Alamat email'), findsOneWidget);
    });

    testWidgets('3. VerifikasiEmailPage handles 4-digit OTP input and enables button',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: VerifikasiEmailPage(identifier: 'test@qcumber.com'),
        ),
      );
      await tester.pump();

      expect(find.text('Verifikasi email'), findsOneWidget);
      expect(find.text('Kode verifikasi'), findsOneWidget);
      expect(find.text('Kirim ulang kode'), findsOneWidget);

      // 4 OTP text fields
      final textFields = find.byType(TextField);
      expect(textFields, findsNWidgets(4));

      // Enter digits
      await tester.enterText(textFields.at(0), '1');
      await tester.pump();
      await tester.enterText(textFields.at(1), '2');
      await tester.pump();
      await tester.enterText(textFields.at(2), '3');
      await tester.pump();
      await tester.enterText(textFields.at(3), '4');
      await tester.pump();

      // Tap "Kirim"
      await tester.tap(find.text('Kirim'));
      await tester.pumpAndSettle();

      // Navigated to ResetPasswordPage
      expect(find.text('Lupa Password'), findsOneWidget);
    });

    testWidgets('4. ResetPasswordPage validates matching passwords',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ResetPasswordPage(),
        ),
      );
      await tester.pump();

      expect(find.text('Lupa Password'), findsOneWidget);
      expect(find.text('Buat kata sandi baru'), findsOneWidget);
      expect(find.text('Konfirmasi kata sandi baru'), findsOneWidget);
      expect(find.text('Simpan Kata sandi Baru'), findsOneWidget);

      final textFields = find.byType(TextField);
      expect(textFields, findsNWidgets(2));

      // Enter mismatched passwords
      await tester.enterText(textFields.at(0), 'secret123');
      await tester.enterText(textFields.at(1), 'mismatch456');
      await tester.pump();

      // Button should be disabled because passwords don't match
      final buttonFinder = find.widgetWithText(ElevatedButton, 'Simpan Kata sandi Baru');
      final ElevatedButton button = tester.widget(buttonFinder);
      expect(button.onPressed, isNull);

      // Now enter matching passwords
      await tester.enterText(textFields.at(1), 'secret123');
      await tester.pump();

      // Button is now enabled
      final ElevatedButton enabledButton = tester.widget(buttonFinder);
      expect(enabledButton.onPressed, isNotNull);

      // Tap button to submit
      await tester.tap(buttonFinder);
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Kata sandi berhasil diubah! Silahkan masuk kembali.'), findsOneWidget);

      // Clean up SnackBar
      ScaffoldMessenger.of(tester.element(find.text('Lupa Password')))
          .hideCurrentSnackBar();
      await tester.pump(const Duration(milliseconds: 300));
    });

    testWidgets('5. LoginPage navigates to LupaPasswordPage when tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginPage(),
        ),
      );
      await tester.pump();

      final lupaText = find.text('Lupa Password');
      expect(lupaText, findsOneWidget);

      await tester.tap(lupaText);
      await tester.pumpAndSettle();

      expect(find.byType(LupaPasswordPage), findsOneWidget);
    });
  });
}
