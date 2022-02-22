import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/cinema/seats_vo.dart';

part 'get_cinema_seating_plan_response.g.dart';

@JsonSerializable()
class GetCinemaSeatingPlanResponse {

  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  List<List<SeatsVO>>? data;

  GetCinemaSeatingPlanResponse(this.code, this.message, this.data);

  factory GetCinemaSeatingPlanResponse.fromJson(Map<String, dynamic> json) => _$GetCinemaSeatingPlanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCinemaSeatingPlanResponseToJson(this);
}