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

  @override
  String toString() {
    return 'SeatsVO{id: $id, type: $type, seatName: $seatName, symbol: $symbol, price: $price, isSelected: $isSelected}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeatsVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          type == other.type &&
          seatName == other.seatName &&
          symbol == other.symbol &&
          price == other.price &&
          isSelected == other.isSelected;

  @override
  int get hashCode =>
      id.hashCode ^
      type.hashCode ^
      seatName.hashCode ^
      symbol.hashCode ^
      price.hashCode ^
      isSelected.hashCode;
}