// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_snacks_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSnacksListResponse _$GetSnacksListResponseFromJson(
        Map<String, dynamic> json) =>
    GetSnacksListResponse(
      json['code'] as int?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => SnacksVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSnacksListResponseToJson(
        GetSnacksListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
