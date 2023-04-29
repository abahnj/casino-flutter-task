import 'package:casino_test/domain/entities/character_entity.dart';
import 'package:casino_test/domain/entities/characters_list_entity.dart';
import 'package:casino_test/domain/entities/location_entity.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('CharactersListEntity Test Suite:', () {
    test('Check if characters list is empty', () {
      const emptyCharactersList = CharactersListEntity(info: PageInfoEntity(count: 0, pages: 0, next: null, previous: null), characters: []);
      expect(emptyCharactersList.isEmpty, isTrue);
    });

    test('Check if characters list is not empty', () {
      const characterEntity = CharacterEntity(
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
    ); // Replace with your CharacterEntity instantiation
      const nonEmptyCharactersList = CharactersListEntity(info: PageInfoEntity(count: 1, pages: 1, next: null, previous: null), characters: [characterEntity]);
      expect(nonEmptyCharactersList.isEmpty, isFalse);
    });
  });

  group('PageInfoEntity Test Suite:', () {
    test('Check nextPage when next is null', () {
      const pageInfo = PageInfoEntity(count: 0, pages: 0, next: null, previous: null);
      expect(pageInfo.nextPage, isNull);
    });

    test('Check nextPage when next is not null', () {
      const pageInfo = PageInfoEntity(count: 1, pages: 2, next: 'https://example.com/api/characters?page=2', previous: null);
      expect(pageInfo.nextPage, 2);
    });
  });

}