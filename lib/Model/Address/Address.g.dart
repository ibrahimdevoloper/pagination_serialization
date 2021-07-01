// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    json['street'] as String,
    json['city'] as String,
    json['suite'] as String,
    json['zipcode'] as String,
    Geo.fromJson(json['geo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'street': instance.street,
      'city': instance.city,
      'suite': instance.suite,
      'zipcode': instance.zipcode,
      'geo': instance.geo.toJson(),
    };
