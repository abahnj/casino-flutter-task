import 'package:casino_test/core/result_monad.dart';
import 'package:casino_test/data/repository/characters_repository.dart';
import 'package:casino_test/domain/entities/character_entity.dart';
import 'package:casino_test/domain/entities/characters_list_entity.dart';
import 'package:casino_test/domain/entities/location_entity.dart';
import 'package:casino_test/domain/usecases/get_characters_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

const testCharactersListEntity = CharactersListEntity(
  info: PageInfoEntity(
    count: 10,
    pages: 2,
    next: 'https://rickandmortyapi.com/api/character/?page=2',
    previous: null,
  ),
  characters: [
    CharacterEntity(
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
    ),
  ],
);

void main() {
  group('GetCharacters', () {
    late _MockCharactersRepository repository;
    late GetCharacters getCharacters;

    setUp(() {
      repository = _MockCharactersRepository();
      getCharacters = GetCharacters(repository);
    });

    test('returns CharactersListEntity when repository returns successfully',
        () async {
      // Arrange
      const testPage = 1;
      when(() => repository.getCharacters(testPage)).thenAnswer(
          (_) async => const SuccessResult(data: testCharactersListEntity));

      // Act
      final result = await getCharacters(testPage);

      // Assert
      expect(
          result,
          const SuccessResult<CharactersListEntity, Error>(
              data: testCharactersListEntity));
      verify(() => repository.getCharacters(testPage)).called(1);
    });

    test('returns Error when repository returns an error', () async {
      // Arrange
      const testPage = 1;
      final testError = Error();
      when(() => repository.getCharacters(testPage))
          .thenAnswer((_) async => ErrorResult(error: testError));

      // Act
      final result = await getCharacters(testPage);

      // Assert
      expect(
          result, ErrorResult<CharactersListEntity, Error>(error: testError));
      verify(() => repository.getCharacters(testPage)).called(1);
    });
  });
}

class _MockCharactersRepository extends Mock implements CharactersRepository {}
