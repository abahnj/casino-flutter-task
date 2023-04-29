import 'package:casino_test/core/result_monad.dart';
import 'package:casino_test/data/data_sources/character_remote_datasource.dart';
import 'package:casino_test/data/models/character.dart';
import 'package:casino_test/data/models/characters_list.dart';
import 'package:casino_test/data/models/location.dart';
import 'package:casino_test/data/repository/characters_repository.dart';
import 'package:casino_test/data/repository/characters_repository_impl.dart';
import 'package:casino_test/domain/entities/characters_list_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late CharactersRepository repository;
  late _MockCharacterRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = _MockCharacterRemoteDataSource();
    repository = CharactersRepositoryImpl(mockRemoteDataSource);
  });

  group('getCharacters', () {
    const testPage = 1;
    final testCharactersList = CharactersList(
      info: const PageInfo(
        count: 1,
        pages: 1,
        next: null,
        previous: null,
      ),
      characters: [
        Character(
          id: 1,
          name: 'Rick Sanchez',
          status: 'Alive',
          species: 'Human',
          type: '',
          gender: 'Male',
          origin: const Location(
              name: 'Earth (C-137)',
              url: 'https://rickandmortyapi.com/api/location/1'),
          location: const Location(
              name: 'Earth (Replacement Dimension)',
              url: 'https://rickandmortyapi.com/api/location/20'),
          image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
          episode: const ['https://rickandmortyapi.com/api/episode/1'],
        ),
      ],
    );

    test('returns CharactersListEntity on successful data retrieval', () async {
      // Arrange
      when(() => mockRemoteDataSource.getCharacters(testPage))
          .thenAnswer((_) async => SuccessResult(data: testCharactersList));

      // Act
      final result = await repository.getCharacters(testPage);

      // Assert
      expect(result, isA<SuccessResult<CharactersListEntity, Object>>());
      final successResult =
          result as SuccessResult<CharactersListEntity, Object>;
      expect(successResult.data.characters, isNotEmpty);
    });

    test('returns Error on failed data retrieval', () async {
      // Arrange
      when(() => mockRemoteDataSource.getCharacters(testPage)).thenAnswer(
          (_) async => ErrorResult(error: Exception('Data retrieval failed')));

      // Act
      final result = await repository.getCharacters(testPage);

      // Assert
      expect(result, isA<ErrorResult>());
      final errorResult = result as ErrorResult;
      expect(errorResult.error, isA<Exception>());
    });
  });
}

class _MockCharacterRemoteDataSource extends Mock
    implements CharacterRemoteDataSource {}
