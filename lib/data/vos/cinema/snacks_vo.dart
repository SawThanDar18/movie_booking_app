import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

part 'snacks_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_SNACKS_VO, adapterName: "SnacksVOAdapter")
class SnacksVO {

  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "name")
  @HiveField(1)
  String? snackName;

  @JsonKey(name: "description")
  @HiveField(2)
  String? snackDetail;

  @JsonKey(name: "price")
  @HiveField(3)
  int? snackPrice;

  @JsonKey(name: "image")
  @HiveField(4)
  String? snackImage;

  @HiveField(5)
  int? quantity;

  SnacksVO(this.id, this.snackName, this.snackDetail, this.snackPrice,
      this.snackImage, this.quantity);

  factory SnacksVO.fromJson(Map<String, dynamic> json) => _$SnacksVOFromJson(json);

  Map<String, dynamic> toJson() => _$SnacksVOToJson(this);

  @override
  String toString() {
    return 'SnacksVO{id: $id, snackName: $snackName, snackDetail: $snackDetail, snackPrice: $snackPrice, snackImage: $snackImage, quantity: $quantity}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SnacksVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          snackName == other.snackName &&
          snackDetail == other.snackDetail &&
          snackPrice == other.snackPrice &&
          snackImage == other.snackImage &&
          quantity == other.quantity;

  @override
  int get hashCode =>
      id.hashCode ^
      snackName.hashCode ^
      snackDetail.hashCode ^
      snackPrice.hashCode ^
      snackImage.hashCode ^
      quantity.hashCode;
}