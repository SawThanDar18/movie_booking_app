import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/cinema/user_booking_vo.dart';

part 'get_checkout_response.g.dart';

@JsonSerializable()
class GetCheckOutResponse {

  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  UserBookingVO? data;

  GetCheckOutResponse(this.code, this.message, this.data);

  factory GetCheckOutResponse.fromJson(Map<String, dynamic> json) => _$GetCheckOutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCheckOutResponseToJson(this);
}