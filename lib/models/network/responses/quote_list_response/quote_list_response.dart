import 'package:json_annotation/json_annotation.dart';
import 'package:quokka/models/network/responses/quote_response/quote_response.dart';

part 'quote_list_response.g.dart';

@JsonSerializable()
class QuoteListResponse {
  final List<QuoteResponse> quotes;

  const QuoteListResponse({required this.quotes});

  factory QuoteListResponse.fromJson(Map<String, dynamic> json) =>
      _$QuoteListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteListResponseToJson(this);
}
