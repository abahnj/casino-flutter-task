import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/location_entity.dart';

part 'location.g.dart';

@JsonSerializable()
class Location extends LocationEntity {
  const Location({required super.name, required super.url});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
