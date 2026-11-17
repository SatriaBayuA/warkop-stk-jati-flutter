
import 'package:flutter_test/flutter_test.dart';
import 'package:katalog_warkop_stk/main.dart';

void main() {
  testWidgets('Warkop STK Jati tampil', (WidgetTester tester) async {
    await tester.pumpWidget(const WarkopApp());

    expect(find.text('Warkop STK Jati'), findsOneWidget);
  });
}
