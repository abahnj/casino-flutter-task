import 'package:casino_test/domain/entities/character_entity.dart';
import 'package:casino_test/domain/entities/location_entity.dart';
import 'package:casino_test/presentation/ui/character_detail_page.dart';
import 'package:casino_test/presentation/ui/widgets/character_card.dart';
import 'package:casino_test/presentation/ui/widgets/character_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CharacterCard', () {
    const testCharacter = CharacterEntity(
      id: 1,
      name: 'Rick',
      status: 'Alive',
      species: 'Human',
      type: '',
      gender: 'Male',
      origin: LocationEntity(
          name: 'Earth', url: 'https://rickandmortyapi.com/api/location/1'),
      location: LocationEntity(
          name: 'Earth', url: 'https://rickandmortyapi.com/api/location/20'),
      image: 'https://rick.png',
      episode: ['https://rickandmortyapi.com/api/episode/1'],
    );

    testWidgets(
        'displays character image, name, status circle, and status text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CharacterCard(character: testCharacter),
          ),
        ),
      );

      expect(find.byType(CharacterImage), findsOneWidget);
      expect(find.text('Rick'), findsOneWidget);
      expect(find.byType(CharacterStatusCircle), findsOneWidget);
      expect(find.text('Alive - Human'), findsOneWidget);
    });

    testWidgets('navigates to CharacterDetailPage when tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            body: CharacterCard(character: testCharacter),
          ),
          routes: {
            '/character_detail': (context) =>
                const CharacterDetailPage(character: testCharacter),
          },
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      expect(find.byType(CharacterDetailPage), findsOneWidget);
    });
  });
}
