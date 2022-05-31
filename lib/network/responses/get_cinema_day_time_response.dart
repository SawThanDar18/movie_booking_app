
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/cinema/day_time_slots_vo.dart';

part 'get_cinema_day_time_response.g.dart';

@JsonSerializable()
class GetCinemaDayTimeResponse {

  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  List<DayTimeSlotsVO>? data;

  GetCinemaDayTimeResponse(this.code, this.message, this.data);

  factory GetCinemaDayTimeResponse.fromJson(Map<String, dynamic> json) => _$GetCinemaDayTimeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCinemaDayTimeResponseToJson(this);
}