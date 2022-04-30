import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

part 'collection_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_COLLECTION_VO, adapterName: "CollectionVOAdapter")
class CollectionVO {

  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "name")
  @HiveField(1)
  String? name;

  @JsonKey(name: "poster_path")
  @HiveField(2)
  String? posterPath;

  @JsonKey(name: "backdrop_path")
  @HiveField(3)
  String? backdropPath;

  CollectionVO(this.id, this.name, this.posterPath, this.backdropPath);

  factory CollectionVO.fromJson(Map<String, dynamic> json) => _$CollectionVOFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionVOToJson(this);

  @override
  String toString() {
    return 'CollectionVO{id: $id, name: $name, posterPath: $posterPath, backdropPath: $backdropPath}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectionVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          posterPath == other.posterPath &&
          backdropPath == other.backdropPath;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ posterPath.hashCode ^ backdropPath.hashCode;
}