import 'package:json_annotation/json_annotation.dart';

part 'save_snacks_vo.g.dart';

@JsonSerializable()
class SaveSnacksVO {

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "quantity")
  int? quantity;

  SaveSnacksVO(this.id, this.quantity);

  factory SaveSnacksVO.fromJson(Map<String, dynamic> json) => _$SaveSnacksVOFromJson(json);

  Map<String, dynamic> toJson() => _$SaveSnacksVOToJson(this);


}