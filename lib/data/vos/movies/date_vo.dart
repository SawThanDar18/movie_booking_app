import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

part 'date_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_DATE_VO, adapterName: "DateVOAdapter")
class DateVO {

  @JsonKey(name: "maximum")
  @HiveField(0)
  String? maximum;

  @JsonKey(name: "minimum")
  @HiveField(1)
  String? minimum;

  DateVO(this.maximum, this.minimum);

  factory DateVO.fromJson(Map<String, dynamic> json) => _$DateVOFromJson(json);

  Map<String, dynamic> toJson() => _$DateVOToJson(this);

  @override
  String toString() {
    return 'DateVO{maximum: $maximum, minimum: $minimum}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateVO &&
          runtimeType == other.runtimeType &&
          maximum == other.maximum &&
          minimum == other.minimum;

  @override
  int get hashCode => maximum.hashCode ^ minimum.hashCode;
}