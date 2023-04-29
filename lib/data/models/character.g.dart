// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      name: json['name'] as String,
      image: json['image'] as String,
      id: json['id'] as int,
      status: json['status'] as String,
      species: json['species'] as String,
      type: json['type'] as String,
      gender: json['gender'] as String,
      episode:
          (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
      origin: const LocationEntityConverter()
          .fromJson(json['origin'] as Map<String, dynamic>),
      location: const LocationEntityConverter()
          .fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'species': instance.species,
      'type': instance.type,
      'gender': instance.gender,
      'origin': const LocationEntityConverter().toJson(instance.origin),
      'location': const LocationEntityConverter().toJson(instance.location),
      'image': instance.image,
      'episode': instance.episode,
    };
