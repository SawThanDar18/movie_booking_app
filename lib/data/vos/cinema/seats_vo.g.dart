// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seats_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatsVO _$SeatsVOFromJson(Map<String, dynamic> json) => SeatsVO(
      json['id'] as int?,
      json['type'] as String?,
      json['seat_name'] as String?,
      json['symbol'] as String?,
      json['price'] as int?,
      json['isSelected'] as bool?,
    );

Map<String, dynamic> _$SeatsVOToJson(SeatsVO instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'seat_name': instance.seatName,
      'symbol': instance.symbol,
      'price': instance.price,
      'isSelected': instance.isSelected,
    };
