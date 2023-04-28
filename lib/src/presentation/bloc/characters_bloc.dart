import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:casino_test/src/core/models/persistent_bloc_state.dart';
import 'package:casino_test/src/domain/usecases/get_characters_use_case.dart';
import 'package:casino_test/src/presentation/bloc/characters_event.dart';
import 'package:casino_test/src/presentation/bloc/characters_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final GetCharacters _getCharacters;

  CharactersBloc(
    this._getCharacters,
  ) : super(CharactersState.loading(null)) {
    on<FetchCharacters>(
      (_, emitter) => _fetchCharacters(emitter),
      transformer: droppable(),
    );
    on<RetryAfterFailure>(
      (_, emitter) => _fetchCharacters(emitter),
    );
  }

  Future<void> _fetchCharacters(Emitter<CharactersState> emit) async {
    if (state.data != null && state is PersistentLoadingCubitState) return;

    emit(state.toLoading(state.data));

    final pageToFetch = _pageToFetch(state.data);

    if (pageToFetch == null) return;

    final result = await _getCharacters(pageToFetch);

    result.match(
      onSuccess: (characterList) {
        final updatedCharacters = state.data?.addNewCharacters(characterList);
        emit(state.toLoaded(
            updatedCharacters ?? CharactersData(characterList: characterList)));
      },
      onError: (_) =>
          emit(state.toError(_, data: state.data?.copyWith(hasError: true))),
    );
  }

  int? _pageToFetch(CharactersData? data) {
    if (data != null) {
      return data.characterList.info.nextPage;
    }
    return 1;
  }
}
