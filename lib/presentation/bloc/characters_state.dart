import 'package:casino_test/core/models/persistent_bloc_state.dart';
import 'package:casino_test/domain/entities/characters_list_entity.dart';
import 'package:equatable/equatable.dart';

typedef CharactersState = PersistentBlocState<CharactersData, Object>;
typedef LoadedCharactersState
    = PersistentLoadedBlocState<CharactersData, Object>;

class CharactersData extends Equatable {
  final CharactersListEntity characterList;
  final bool hasError;

  const CharactersData({required this.characterList, this.hasError = false});

  CharactersData addNewCharacters(CharactersListEntity newCharacters) {
    final characters = characterList.characters + newCharacters.characters;
    final info = newCharacters.info;
    return CharactersData(
      characterList: CharactersListEntity(
        info: info,
        characters: characters,
      ),
    );
  }

  CharactersData copyWith({
    CharactersListEntity? characterList,
    bool? hasError,
  }) {
    return CharactersData(
        characterList: characterList ?? this.characterList,
        hasError: hasError ?? this.hasError);
  }

  @override
  List<Object> get props => [characterList];
}
