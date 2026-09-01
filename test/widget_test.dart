import 'package:flutter_test/flutter_test.dart';
import 'package:famous_persons_app/main.dart';

void main() {
  testWidgets('App starts', (tester) async {
    await tester.pumpWidget(const FamousPersonsApp());
    expect(find.text('Famous Persons'), findsOneWidget);
  });
}
