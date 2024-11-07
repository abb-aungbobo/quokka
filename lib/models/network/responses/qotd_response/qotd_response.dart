import 'package:json_annotation/json_annotation.dart';
import 'package:quokka/models/network/responses/quote_response/quote_response.dart';

part 'qotd_response.g.dart';

@JsonSerializable()
class QotdResponse {
  final QuoteResponse quote;

  const QotdResponse({required this.quote});

  factory QotdResponse.fromJson(Map<String, dynamic> json) =>
      _$QotdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QotdResponseToJson(this);
}
