// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Geo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Geo _$GeoFromJson(Map<String, dynamic> json) {
  return Geo(
    json['lat'] as String,
    json['lng'] as String,
  );
}

Map<String, dynamic> _$GeoToJson(Geo instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
