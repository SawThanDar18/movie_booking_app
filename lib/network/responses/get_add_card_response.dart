import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/users/card_vo.dart';

part 'get_add_card_response.g.dart';

@JsonSerializable()
class GetAddCardResponse {

  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  List<CardVO>? data;

  GetAddCardResponse(this.code, this.message, this.data);

  factory GetAddCardResponse.fromJson(Map<String, dynamic> json) => _$GetAddCardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAddCardResponseToJson(this);
}