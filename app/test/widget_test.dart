import 'package:flutter_test/flutter_test.dart';

import 'package:app/app/app.dart';

void main() {
  testWidgets('shows home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const BuzzzyApp());

    expect(find.text('Buzzzy'), findsOneWidget);
  });
}
