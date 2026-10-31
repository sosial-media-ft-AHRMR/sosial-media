import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sosial_media/ubah_sandi/ubah_sandi.dart';

void main() {
  testWidgets('UbahSandiPage renders all components and validates input correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: UbahSandiPage(),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Verify Top Bar title
    expect(find.text('Ubah Kata Sandi'), findsOneWidget);

    // 2. Verify Info Banner text
    expect(
      find.text(
        'Setelah kata sandi diubah, silahkan masuk kembali menggunakan kata sandi baru',
      ),
      findsOneWidget,
    );

    // 3. Verify Form Labels
    expect(find.text('Kata sandi lama'), findsOneWidget);
    expect(find.text('Buat kata sandi baru'), findsOneWidget);
    expect(find.text('Konfirmasi kata sandi baru'), findsOneWidget);

    // 4. Verify initial text 'as12' in Kata sandi lama
    expect(find.text('as12'), findsOneWidget);

    // 5. Verify Button
    final buttonFinder =
        find.widgetWithText(ElevatedButton, 'Simpan Kata sandi Baru');
    expect(buttonFinder, findsOneWidget);

    // 6. Test mismatch validation
    // Enter new password
    final textFields = find.byType(TextField);
    expect(textFields, findsNWidgets(3));

    await tester.enterText(textFields.at(1), 'passwordBaru123');
    await tester.enterText(textFields.at(2), 'passwordBeda');
    await tester.pumpAndSettle();

    await tester.tap(buttonFinder);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Konfirmasi kata sandi baru tidak cocok'), findsOneWidget);

    // 7. Test matching password
    await tester.enterText(textFields.at(2), 'passwordBaru123');
    await tester.pump();

    await tester.tap(buttonFinder);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(
      find.text(
        'Kata sandi berhasil diubah. Silahkan masuk kembali menggunakan kata sandi baru.',
      ),
      findsOneWidget,
    );
  });
}
