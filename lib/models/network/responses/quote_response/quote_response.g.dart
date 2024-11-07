// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteResponse _$QuoteResponseFromJson(Map<String, dynamic> json) =>
    QuoteResponse(
      id: (json['id'] as num).toInt(),
      favoritesCount: (json['favorites_count'] as num).toInt(),
      author: json['author'] as String?,
      body: json['body'] as String,
    );

Map<String, dynamic> _$QuoteResponseToJson(QuoteResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'favorites_count': instance.favoritesCount,
      'author': instance.author,
      'body': instance.body,
    };
