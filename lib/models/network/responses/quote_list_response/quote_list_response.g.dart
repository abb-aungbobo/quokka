// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteListResponse _$QuoteListResponseFromJson(Map<String, dynamic> json) =>
    QuoteListResponse(
      quotes: (json['quotes'] as List<dynamic>)
          .map((e) => QuoteResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuoteListResponseToJson(QuoteListResponse instance) =>
    <String, dynamic>{
      'quotes': instance.quotes,
    };
