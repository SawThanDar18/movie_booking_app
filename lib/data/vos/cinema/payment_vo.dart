import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

part 'payment_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_PAYMENT_VO, adapterName: "PaymentVOAdapter")
class PaymentVO {

  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "name")
  @HiveField(1)
  String? paymentName;

  @JsonKey(name: "description")
  @HiveField(2)
  String? paymentDetail;

  @HiveField(3)
  bool? isSelected;

  PaymentVO(this.id, this.paymentName, this.paymentDetail);

  factory PaymentVO.fromJson(Map<String, dynamic> json) => _$PaymentVOFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentVOToJson(this);

}