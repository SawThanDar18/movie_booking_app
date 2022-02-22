// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_checkout_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCheckOutResponse _$GetCheckOutResponseFromJson(Map<String, dynamic> json) =>
    GetCheckOutResponse(
      json['code'] as int?,
      json['message'] as String?,
      json['data'] == null
          ? null
          : UserBookingVO.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetCheckOutResponseToJson(
        GetCheckOutResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
