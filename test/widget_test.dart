// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_coffee/data/api.dart';
import 'package:flutter_coffee/data/service.dart';
import 'package:flutter_coffee/ui/welcome.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_coffee/main.dart';

void main() {
  final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('WelcomeScreen has a title and image', (WidgetTester tester) async {
    await binding.setSurfaceSize(const Size(1920, 1080));

    final coffeeService = CoffeeService(api: CoffeeAPI());

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: WelcomeScreen(coffeeService: coffeeService)));
    await tester.pumpAndSettle();

    // Verify that our WelcomeScreen has "Welcome to\nKaffiKrútur" as a title.
    expect(find.text('Welcome to\nKaffiKrútur'), findsOneWidget);

    // Verify that our WelcomeScreen has an image.
    expect(find.byType(Image), findsWidgets);
  });
}
