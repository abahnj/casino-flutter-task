import 'package:casino_test/domain/entities/character_entity.dart';
import 'package:casino_test/domain/entities/location_entity.dart';
import 'package:casino_test/presentation/ui/character_detail_page.dart';
import 'package:casino_test/presentation/ui/widgets/character_card.dart';
import 'package:casino_test/presentation/ui/widgets/character_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CharacterDetailPage', () {
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
          name: 'Earth 347',
          url: 'https://rickandmortyapi.com/api/location/20'),
      image: 'https://rick.png',
      episode: ['https://rickandmortyapi.com/api/episode/1'],
    );

    testWidgets(
        'displays character image, name, status circle, status text, and details',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CharacterDetailPage(character: testCharacter),
          ),
        ),
      );

      expect(find.byType(CharacterImage), findsOneWidget);
      expect(find.text('Rick'), findsNWidgets(2));
      expect(find.byType(HeroCharacterStatus), findsOneWidget);
      expect(find.text('Alive - Human'), findsOneWidget);
      expect(find.text('Gender:'), findsOneWidget);
      expect(find.text('Male'), findsOneWidget);
      expect(find.text('Origin:'), findsOneWidget);
      expect(find.text('Earth'), findsOneWidget);
      expect(find.text('Last known location:'), findsOneWidget);
      expect(find.text('Earth 347'), findsOneWidget);
      expect(find.text('Number of episodes:'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('has an AppBar with the title set to the character name',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CharacterDetailPage(character: testCharacter),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.widgetWithText(AppBar, 'Rick'), findsOneWidget);
    });
  });
}
