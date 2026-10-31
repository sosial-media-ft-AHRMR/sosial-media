import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sosial_media/laporkan_masalah/laporkan_masalah.dart';

void main() {
  testWidgets('LaporkanMasalahPage renders elements and handles interactions',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LaporkanMasalahPage(),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Verify Top Bar title
    expect(find.text('Laporkan Masalah'), findsOneWidget);

    // 2. Verify Categories exist
    expect(find.text('Pilih Kategori'), findsOneWidget);
    expect(find.text('Macet'), findsOneWidget);
    expect(find.text('Gagal Upload'), findsOneWidget);
    expect(find.text('Chat & Notif'), findsOneWidget);
    expect(find.text('Akun/Login'), findsOneWidget);
    expect(find.text('Lainnya'), findsOneWidget);

    // 3. Tap category 'Macet'
    await tester.tap(find.text('Macet'));
    await tester.pumpAndSettle();

    // 4. Type into 'Lainnya' text field
    final lainnyaField = find.byType(TextField).first;
    await tester.enterText(lainnyaField, 'Bug aplikasi');
    await tester.pumpAndSettle();
    expect(find.text('Bug aplikasi'), findsOneWidget);

    // 5. Verify Detail Kendala
    expect(find.text('Detail Kendala'), findsOneWidget);
    final detailField = find.byType(TextField).last;
    await tester.enterText(detailField, 'Aplikasi mengalami kendala saat upload');
    await tester.pumpAndSettle();
    expect(find.text('Aplikasi mengalami kendala saat upload'), findsOneWidget);

    // 6. Verify Sertakan Log Sistem
    expect(find.text('Sertakan Log Sistem'), findsOneWidget);
    expect(
      find.text(
        'Kirim info teknis perangkat otomatis agar tim lebih cepat melacak bug',
      ),
      findsOneWidget,
    );

    // 7. Toggle switch
    final switchFinder = find.byType(GestureDetector).last;
    await tester.tap(switchFinder);
    await tester.pumpAndSettle();

    // 8. Verify Kirim Laporan button
    final kirimButton = find.widgetWithText(ElevatedButton, 'Kirim Laporan');
    expect(kirimButton, findsOneWidget);

    // Scroll until Kirim Laporan is visible
    await tester.ensureVisible(kirimButton);
    await tester.pumpAndSettle();

    // Tap Kirim Laporan
    await tester.tap(kirimButton);
    await tester.pumpAndSettle();

    // 9. Verify ReportProcessedDialog appears
    expect(find.text('Laporan Diproses'), findsOneWidget);
    expect(
      find.text(
        'Terima kasih sudah melapor. Tim kami sedang memeriksa kendala ini dalam 1x24 jam ke depan',
      ),
      findsOneWidget,
    );
    expect(find.text('Selesai'), findsOneWidget);

    // Tap Selesai
    await tester.tap(find.text('Selesai'));
    await tester.pumpAndSettle();

    // Dialog should be dismissed
    expect(find.text('Laporan Diproses'), findsNothing);
  });
}

