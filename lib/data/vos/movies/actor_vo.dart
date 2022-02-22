import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/movies/movie_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

part 'actor_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_ACTOR_VO, adapterName: "ActorVOAdapter")
class ActorVO {

  @JsonKey(name: "adult")
  @HiveField(0)
  bool? adult;

  @JsonKey(name: "id")
  @HiveField(1)
  int? id;

  @JsonKey(name: "known_for")
  @HiveField(2)
  List<MovieVO>? knownFor;

  @JsonKey(name: "popularity")
  @HiveField(3)
  double? popularity;

  @JsonKey(name: "gender")
  @HiveField(4)
  int? gender;

  @JsonKey(name: "known_for_department")
  @HiveField(5)
  String? knownForDepartment;

  @JsonKey(name: "name")
  @HiveField(6)
  String? name;

  @JsonKey(name: "profile_path")
  @HiveField(7)
  String? profilePath;

  @JsonKey(name: "original_name")
  @HiveField(8)
  String? originalName;

  @JsonKey(name: "cast_id")
  @HiveField(9)
  int? castId;

  @JsonKey(name: "character")
  @HiveField(10)
  String? character;

  @JsonKey(name: "credit_id")
  @HiveField(11)
  String? creditId;

  @JsonKey(name: "order")
  @HiveField(12)
  int? order;

  ActorVO(
      this.adult,
      this.id,
      this.knownFor,
      this.popularity,
      this.gender,
      this.knownForDepartment,
      this.name,
      this.profilePath,
      this.originalName,
      this.castId,
      this.character,
      this.creditId,
      this.order);

  factory ActorVO.fromJson(Map<String, dynamic> json) => _$ActorVOFromJson(json);

  Map<String, dynamic> toJson() => _$ActorVOToJson(this);
}