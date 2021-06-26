import 'package:json_annotation/json_annotation.dart';
import 'package:pagination_serialization/Model/Geo/Geo.dart';

part 'Address.g.dart';

@JsonSerializable()
class Address {
  String street;
  String city;
  String suite;
  String zipcode;
  Geo geo;

  Address(this.street, this.city, this.suite, this.zipcode, this.geo);

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
