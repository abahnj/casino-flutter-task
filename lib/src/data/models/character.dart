import 'package:casino_test/src/data/models/location.dart';
import 'package:casino_test/src/domain/entities/character_entity.dart';
import 'package:casino_test/src/domain/entities/location_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
@LocationEntityConverter()
class Character extends CharacterEntity {
  Character({
    required super.name,
    required super.image,
    required super.id,
    required super.status,
    required super.species,
    required super.type,
    required super.gender,
    required super.episode,
    required Location origin,
    required Location location,
  }) : super(
          origin: LocationEntity(name: origin.name, url: origin.url),
          location: LocationEntity(name: location.name, url: location.url),
        );

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
