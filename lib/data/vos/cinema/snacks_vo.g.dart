// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snacks_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SnacksVOAdapter extends TypeAdapter<SnacksVO> {
  @override
  final int typeId = 13;

  @override
  SnacksVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SnacksVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as int?,
      fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SnacksVO obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.snackName)
      ..writeByte(2)
      ..write(obj.snackDetail)
      ..writeByte(3)
      ..write(obj.snackPrice)
      ..writeByte(4)
      ..write(obj.snackImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SnacksVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnacksVO _$SnacksVOFromJson(Map<String, dynamic> json) => SnacksVO(
      json['id'] as int?,
      json['name'] as String?,
      json['description'] as String?,
      json['price'] as int?,
      json['image'] as String?,
    )..quantity = json['quantity'] as int?;

Map<String, dynamic> _$SnacksVOToJson(SnacksVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.snackName,
      'description': instance.snackDetail,
      'price': instance.snackPrice,
      'image': instance.snackImage,
      'quantity': instance.quantity,
    };
