import 'package:casino_test/core/utils/cached_network_image_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CachedNetworkImageWrapper Test Suite:', () {
    testWidgets('Check if test environment', (WidgetTester tester) async {
      expect(isInTest, isTrue);
    });

    testWidgets('Display a placeholder in a test environment',
        (WidgetTester tester) async {
      const imageUrl = 'https://example.com/image.jpg';
      await tester.pumpWidget(
        const MaterialApp(
          home: CachedNetworkImageWrapper(
            imageUrl: imageUrl,
          ),
        ),
      );

      expect(find.byType(Placeholder), findsOneWidget);
      expect(
          find.byWidgetPredicate((Widget widget) =>
              widget is Semantics && widget.properties.value == imageUrl),
          findsOneWidget);
    });

    testWidgets('Display a placeholder with custom width and height',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CachedNetworkImageWrapper(
            imageUrl: 'https://example.com/image.jpg',
            width: 300,
            height: 300,
          ),
        ),
      );

      final placeholder = tester.widget<Placeholder>(find.byType(Placeholder));
      expect(placeholder.fallbackWidth, 300);
      expect(placeholder.fallbackHeight, 300);
    });
  });
}
