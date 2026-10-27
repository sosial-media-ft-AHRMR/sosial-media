import 'package:flutter_test/flutter_test.dart';
import 'package:sosial_media/main.dart';

void main() {
  testWidgets('Splash screen displays Qcumber smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const FigmaToCodeApp());
    expect(find.text('Qcumber'), findsOneWidget);
    expect(find.text('A fresh slice of life'), findsOneWidget);
  });
}
