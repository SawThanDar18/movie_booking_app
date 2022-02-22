// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentVO _$PaymentVOFromJson(Map<String, dynamic> json) => PaymentVO(
      json['id'] as int?,
      json['name'] as String?,
      json['description'] as String?,
    )..isSelected = json['isSelected'] as bool?;

Map<String, dynamic> _$PaymentVOToJson(PaymentVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.paymentName,
      'description': instance.paymentDetail,
      'isSelected': instance.isSelected,
    };
