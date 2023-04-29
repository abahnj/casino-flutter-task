import 'package:casino_test/data/models/character.dart';
import 'package:casino_test/domain/entities/characters_list_entity.dart';
import 'package:json_annotation/json_annotation.dart';

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
      info: info,
      characters: characters,
    );
  }

  @override
  List<Object> get props => [info, characters];

  @override
  String toString() => 'CharactersList(info: $info, characters: $characters)';
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
