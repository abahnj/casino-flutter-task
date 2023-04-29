import 'package:bloc_test/bloc_test.dart';
import 'package:casino_test/core/models/persistent_bloc_state.dart';
import 'package:casino_test/core/result_monad.dart';
import 'package:casino_test/domain/entities/character_entity.dart';
import 'package:casino_test/domain/entities/characters_list_entity.dart';
import 'package:casino_test/domain/entities/location_entity.dart';
import 'package:casino_test/domain/usecases/get_characters_use_case.dart';
import 'package:casino_test/presentation/bloc/characters_bloc.dart';
import 'package:casino_test/presentation/bloc/characters_event.dart';
import 'package:casino_test/presentation/bloc/characters_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late CharactersBloc charactersBloc;
  late _MockGetCharacters mockGetCharacters;

  setUp(() {
    mockGetCharacters = _MockGetCharacters();
    charactersBloc = CharactersBloc(mockGetCharacters);
  });

  tearDown(() {
    charactersBloc.close();
  });

  test('initial state is loading', () {
    expect(charactersBloc.state,
        CharactersState.loading<CharactersData, Object>(null));
  });

  group('FetchCharacters', () {
    blocTest<CharactersBloc, CharactersState>(
      'emits [loading, loaded] when successful',
      build: () {
        when(() => mockGetCharacters(any())).thenAnswer(
            (_) async => SuccessResult(data: createTestCharactersList()));
        return charactersBloc;
      },
      act: (bloc) => bloc.add(const FetchCharacters()),
      expect: () => [
        CharactersState.loading<CharactersData, Object>(null),
        CharactersState.loaded<CharactersData, Object>(
            createTestCharactersData()),
      ],
    );

    blocTest<CharactersBloc, CharactersState>(
      'emits [loading, error] when failed',
      build: () {
        when(() => mockGetCharacters(any())).thenAnswer((_) async =>
            ErrorResult(error: Exception('Data retrieval failed')));
        return charactersBloc;
      },
      act: (bloc) => bloc.add(const FetchCharacters()),
      expect: () => [
        isA<PersistentLoadingCubitState<CharactersData, Object>>(),
        isA<PersistentErrorCubitState<CharactersData, Object>>().having(
          (state) => state.error.toString(),
          'Exception: Data retrieval failed',
          'Exception: Data retrieval failed',
        ),
      ],
    );
  });

  group('RetryAfterFailure', () {
    blocTest<CharactersBloc, CharactersState>(
      'emits [loading, loaded] when retry is successful',
      build: () {
        when(() => mockGetCharacters(any())) //
            .thenAnswer(
                (_) async => SuccessResult(data: createTestCharactersList()));
        return charactersBloc;
      },
      seed: () =>
          CharactersState.error(Exception('Data retrieval failed'), null),
      act: (bloc) => bloc.add(const RetryAfterFailure()),
      expect: () => [
        CharactersState.loading<CharactersData, Object>(null),
        CharactersState.loaded<CharactersData, Object>(
            createTestCharactersData()),
      ],
    );
  });
}

CharactersListEntity createTestCharactersList() {
  return const CharactersListEntity(
    info: PageInfoEntity(
      count: 1,
      pages: 1,
      next: null,
      previous: null,
    ),
    characters: [
      CharacterEntity(
        id: 1,
        name: 'Test Character',
        status: 'Alive',
        species: 'Human',
        type: '',
        gender: 'Male',
        origin: LocationEntity(name: 'Earth', url: ''),
        location: LocationEntity(name: 'Earth', url: ''),
        image: 'https://example.com/test-character.jpg',
        episode: [],
      ),
    ],
  );
}

CharactersData createTestCharactersData() {
  return CharactersData(
    characterList: createTestCharactersList(),
    hasError: false,
  );
}

class _MockGetCharacters extends Mock implements GetCharacters {}
