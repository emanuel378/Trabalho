import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:astrolume/main.dart';

void main() {
  testWidgets('Splash screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AstrolumApp());

    // Verifica que o app inicia sem erros
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}