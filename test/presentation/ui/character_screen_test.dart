import 'package:casino_test/core/di/main_di_module.dart';
import 'package:casino_test/core/models/persistent_bloc_state.dart';
import 'package:casino_test/domain/entities/character_entity.dart';
import 'package:casino_test/domain/entities/characters_list_entity.dart';
import 'package:casino_test/domain/entities/location_entity.dart';
import 'package:casino_test/presentation/bloc/characters_bloc.dart';
import 'package:casino_test/presentation/bloc/characters_event.dart';
import 'package:casino_test/presentation/bloc/characters_state.dart';
import 'package:casino_test/presentation/ui/character_screen.dart';
import 'package:casino_test/presentation/ui/exception_indicators/error_indicator.dart';
import 'package:casino_test/presentation/ui/widgets/character_card.dart';
import 'package:casino_test/presentation/ui/widgets/loading_indicator.dart';
import 'package:casino_test/presentation/ui/widgets/retry_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late CharactersBloc mockCharactersBloc;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    locatorSetup(testBloc: (() => mockCharactersBloc));
  });

  setUp(() {
    mockCharactersBloc = createMockCharactersBloc();
  });

  group('CharacterScreen', () {
    testWidgets('renders CharactersScreenConsumer with CharactersBloc',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<CharactersBloc>.value(
            value: mockCharactersBloc,
            child: const CharacterScreen(),
          ),
        ),
      );

      // Verify that CharactersScreenConsumer is present
      expect(find.byType(CharactersScreenConsumer), findsOneWidget);

      // Verify that the FetchCharacters event is added to the bloc
      verify(() => mockCharactersBloc.add(const FetchCharacters())).called(1);
    });
  });

  group('CharactersScreenConsumer', () {
    testWidgets('renders initial loading state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<CharactersBloc>.value(
            value: mockCharactersBloc,
            child: const CharactersScreenConsumer(),
          ),
        ),
      );
      await tester.pump();

      expect(
          find.byType(LoadingIndicator, skipOffstage: false), findsOneWidget);
      expect(find.byType(ErrorIndicator), findsNothing);
      expect(find.byType(CharacterCard), findsNothing);
    });

    testWidgets('renders next page loading state', (WidgetTester tester) async {
      setMockBlocState(
        mockCharactersBloc,
        state: CharactersState.loading(
          CharactersData(
            characterList: generateCharacterList(3),
            hasError: false,
          ),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<CharactersBloc>.value(
            value: mockCharactersBloc,
            child: const CharactersScreenConsumer(),
          ),
        ),
      );

      expect(find.byType(LoadingIndicator), findsOneWidget);
      expect(find.byType(ErrorIndicator), findsNothing);
      expect(find.byType(CharacterCard), findsNWidgets(3));
    });

    testWidgets('renders success state', (WidgetTester tester) async {
      when(() => mockCharactersBloc.state).thenReturn(
        CharactersState.loaded(
          CharactersData(
            characterList: generateCharacterList(3),
            hasError: false,
          ),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<CharactersBloc>.value(
            value: mockCharactersBloc,
            child: const CharactersScreenConsumer(),
          ),
        ),
      );

      expect(find.byType(LoadingIndicator), findsNothing);
      expect(find.byType(ErrorIndicator), findsNothing);
      expect(find.byType(CharacterCard), findsNWidgets(3));
    });

    testWidgets('renders initial error state', (WidgetTester tester) async {
      when(() => mockCharactersBloc.state).thenReturn(
        CharactersState.error(
          Exception('An error occurred'),
          null,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<CharactersBloc>.value(
            value: mockCharactersBloc,
            child: const CharactersScreenConsumer(),
          ),
        ),
      );

      expect(find.byType(LoadingIndicator), findsNothing);
      expect(find.byType(ErrorIndicator), findsOneWidget);
      expect(find.byType(CharacterCard), findsNothing);
    });

    testWidgets('renders next page error state', (WidgetTester tester) async {
      when(() => mockCharactersBloc.state).thenReturn(
        CharactersState.error(
          Exception('An error occurred'),
          CharactersData(
            characterList: generateCharacterList(3),
            hasError: true,
          ),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<CharactersBloc>.value(
            value: mockCharactersBloc,
            child: const CharactersScreenConsumer(),
          ),
        ),
      );

      expect(find.byType(LoadingIndicator), findsNothing);
      expect(find.byType(ErrorIndicator), findsNothing);
      expect(find.byType(CharacterCard), findsNWidgets(3));
      expect(find.byType(RetryButton), findsOneWidget);
    });
  });
}

class _MockCharactersBloc extends Mock implements CharactersBloc {}

CharactersListEntity generateCharacterList(int count) {
  return CharactersListEntity(
    info: PageInfoEntity(
      count: count,
      pages: 1,
      next: 'https://rickandmortyapi.com/api/character/?page=2',
      previous: null,
    ),
    characters: List<CharacterEntity>.generate(
      count,
      (index) => CharacterEntity(
        id: index,
        name: 'Character $index',
        status: 'Alive',
        species: 'Human',
        type: '',
        gender: 'Male',
        origin: const LocationEntity(name: 'Earth', url: ''),
        location: const LocationEntity(name: 'Mars', url: ''),
        image: 'https://example.com/character_$index.png',
        episode: const [],
      ),
    ),
  );
}

CharactersBloc createMockCharactersBloc({
  CharactersState? state,
}) {
  final charactersBloc = _MockCharactersBloc();
  when(charactersBloc.close).thenAnswer((_) => Future.value());
  setMockBlocState(
    charactersBloc,
    state: state ?? const PersistentLoadingCubitState(data: null),
  );
  return charactersBloc;
}

void setMockBlocState(
  CharactersBloc bloc, {
  required CharactersState state,
}) {
  when(() => bloc.stream).thenAnswer((_) => Stream.value(state));
  when(() => bloc.state).thenAnswer((_) => state);
}
