import 'package:flutter_test/flutter_test.dart';
import 'package:tip_calculator/main.dart';

void main() {
  testWidgets('Tip Calculator loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const TipCalculatorApp());

    expect(find.text('Tip Calculator'), findsOneWidget);
    expect(find.text('Calculate Your Tip'), findsOneWidget);
    expect(find.text('Bill Amount'), findsOneWidget);
    expect(find.text('Tip Percentage'), findsOneWidget);
  });
}
