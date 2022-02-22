import 'package:json_annotation/json_annotation.dart';

part 'payment_vo.g.dart';

@JsonSerializable()
class PaymentVO {

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "name")
  String? paymentName;

  @JsonKey(name: "description")
  String? paymentDetail;

  bool? isSelected;

  PaymentVO(this.id, this.paymentName, this.paymentDetail);

  factory PaymentVO.fromJson(Map<String, dynamic> json) => _$PaymentVOFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentVOToJson(this);

}