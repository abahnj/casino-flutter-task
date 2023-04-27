import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/domain/entities/characters_list_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/character_entity.dart';

part 'characters_list.g.dart';

class CharactersList extends CharactersListEntity {
  const CharactersList({required super.info, required super.characters});

  factory CharactersList.fromJson(Map<String, dynamic> json) {
    return CharactersList(
      info: PageInfo.fromJson(json['info']),
      characters: (json['results'] as List<dynamic>)
          .map((e) => Character.fromJson(e))
          .toList(),
    );
  }

  CharactersListEntity toEntity() {
    return CharactersListEntity(
      info: PageInfoEntity(
        count: info.count,
        pages: info.pages,
        next: info.next,
        previous: info.previous,
      ),
      characters: characters
          .map((character) => CharacterEntity(
                id: character.id,
                name: character.name,
                image: character.image,
                status: character.status,
                species: character.species,
                episode: character.episode,
                type: character.type,
                gender: character.gender,
                origin: character.origin,
                location: character.location,
              ))
          .toList(),
    );
  }

  @override
  List<Object> get props => [info, characters];

  @override
  String toString() => 'CharacterList(info: $info, characters: $characters)';
}

@JsonSerializable()
class PageInfo extends PageInfoEntity {
  const PageInfo({
    required super.count,
    required super.pages,
    super.next,
    super.previous,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) =>
      _$PageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PageInfoToJson(this);

  @override
  List<Object> get props => [count, pages];
}
