// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qotd_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QotdResponse _$QotdResponseFromJson(Map<String, dynamic> json) => QotdResponse(
      quote: QuoteResponse.fromJson(json['quote'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QotdResponseToJson(QotdResponse instance) =>
    <String, dynamic>{
      'quote': instance.quote,
    };
