import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';

part 'get_snacks_list_response.g.dart';

@JsonSerializable()
class GetSnacksListResponse {

  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  List<SnacksVO>? data;

  GetSnacksListResponse(this.code, this.message, this.data);

  factory GetSnacksListResponse.fromJson(Map<String, dynamic> json) => _$GetSnacksListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetSnacksListResponseToJson(this);
}