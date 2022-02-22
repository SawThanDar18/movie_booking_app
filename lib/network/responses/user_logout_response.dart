
import 'package:json_annotation/json_annotation.dart';

part 'user_logout_response.g.dart';

@JsonSerializable()
class UserLogOutResponse {

  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  UserLogOutResponse(this.code, this.message);

  factory UserLogOutResponse.fromJson(Map<String, dynamic> json) => _$UserLogOutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserLogOutResponseToJson(this);
}