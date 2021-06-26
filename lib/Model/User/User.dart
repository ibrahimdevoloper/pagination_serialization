import 'package:json_annotation/json_annotation.dart';
import 'package:pagination_serialization/Model/Address/Address.dart';
import 'package:pagination_serialization/Model/Company/Company.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  int id;
  String name;
  String username;
  String email;
  Address address;
  String phone;
  String website;
  Company company;

  User(this.id, this.name, this.username, this.email, this.address, this.phone,
      this.website, this.company);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
