// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_add_card_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAddCardResponse _$GetAddCardResponseFromJson(Map<String, dynamic> json) =>
    GetAddCardResponse(
      json['code'] as int?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => CardVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAddCardResponseToJson(GetAddCardResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
