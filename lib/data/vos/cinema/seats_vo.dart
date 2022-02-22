import 'package:json_annotation/json_annotation.dart';

part 'seats_vo.g.dart';

@JsonSerializable()
class SeatsVO {

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "type")
  String? type;

  @JsonKey(name: "seat_name")
  String? seatName;

  @JsonKey(name: "symbol")
  String? symbol;

  @JsonKey(name: "price")
  int? price;

  bool? isSelected;

  SeatsVO(this.id, this.type, this.seatName, this.symbol, this.price, this.isSelected);

  factory SeatsVO.fromJson(Map<String, dynamic> json) => _$SeatsVOFromJson(json);

  Map<String, dynamic> toJson() => _$SeatsVOToJson(this);
}