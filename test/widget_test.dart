import 'package:flutter_test/flutter_test.dart';

import 'package:vstech_home_services/app.dart';

void main() {
  testWidgets('App boots and shows the placeholder splash screen', (tester) async {
    await tester.pumpWidget(const VstechHomeServicesApp());
    await tester.pumpAndSettle();

    expect(find.text('VSTech Home Services'), findsOneWidget);
  });
}
