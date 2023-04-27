import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class LocationEntity extends Equatable {
  final String name;
  final String url;

  const LocationEntity({required this.name, required this.url});

  @override
  List<Object?> get props => [name, url];
}

class LocationEntityConverter
    implements JsonConverter<LocationEntity, Map<String, dynamic>> {
  const LocationEntityConverter();

  @override
  LocationEntity fromJson(Map<String, dynamic> json) {
    return LocationEntity(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson(LocationEntity location) {
    return {
      'name': location.name,
      'url': location.url,
    };
  }
}
