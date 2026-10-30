import 'package:flutter_test/flutter_test.dart';
import 'package:sosial_media/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const QcumberApp());
    expect(find.byType(QcumberApp), findsOneWidget);
  });
}
