
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

part 'card_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CARD_VO, adapterName: "CardVOAdapter")
class CardVO {

  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "card_holder")
  @HiveField(1)
  String? cardHolderName;

  @JsonKey(name: "card_number")
  @HiveField(2)
  String? cardNumber;

  @JsonKey(name: "expiration_date")
  @HiveField(3)
  String? cardExpirationDate;

  @JsonKey(name: "card_type")
  @HiveField(4)
  String? cardType;

  CardVO(this.id, this.cardHolderName, this.cardNumber, this.cardExpirationDate,
      this.cardType);

  factory CardVO.fromJson(Map<String, dynamic> json) => _$CardVOFromJson(json);

  Map<String, dynamic> toJson() => _$CardVOToJson(this);

  @override
  String toString() {
    return 'CardVO{id: $id, cardHolderName: $cardHolderName, cardNumber: $cardNumber, cardExpirationDate: $cardExpirationDate, cardType: $cardType}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          cardHolderName == other.cardHolderName &&
          cardNumber == other.cardNumber &&
          cardExpirationDate == other.cardExpirationDate &&
          cardType == other.cardType;

  @override
  int get hashCode =>
      id.hashCode ^
      cardHolderName.hashCode ^
      cardNumber.hashCode ^
      cardExpirationDate.hashCode ^
      cardType.hashCode;
}