import 'package:flutter_test/flutter_test.dart';
import 'package:my_campus_app/core/di/injection_container.dart' as di;
import 'package:my_campus_app/main.dart';

void main() {
  testWidgets('Campus App renders home screen successfully',
      (WidgetTester tester) async {
    await di.sl.reset();
    await di.init();
    await tester.pumpWidget( MyCampusApp());
    await tester.pumpAndSettle();

    expect(find.byType(MyCampusApp), findsOneWidget);
  });
}
