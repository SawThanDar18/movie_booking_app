// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cinema_day_time_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCinemaDayTimeResponse _$GetCinemaDayTimeResponseFromJson(
        Map<String, dynamic> json) =>
    GetCinemaDayTimeResponse(
      json['code'] as int?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => DayTimeSlotsVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCinemaDayTimeResponseToJson(
        GetCinemaDayTimeResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
