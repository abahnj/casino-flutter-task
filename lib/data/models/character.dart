import 'package:casino_test/domain/entities/character_entity.dart';
import 'package:casino_test/domain/entities/location_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
@LocationEntityConverter()
class Character extends CharacterEntity {
  const Character({
    required super.name,
    required super.image,
    required super.id,
    required super.status,
    required super.species,
    required super.type,
    required super.gender,
    required super.episode,
    required super.origin,
    required super.location,
  });

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
