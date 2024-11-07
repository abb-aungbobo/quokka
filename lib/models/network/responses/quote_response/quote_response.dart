import 'package:json_annotation/json_annotation.dart';
import 'package:quokka/ui_component/quote_card_view/quote_card_view_model.dart';

part 'quote_response.g.dart';

@JsonSerializable()
class QuoteResponse {
  final int id;
  @JsonKey(name: "favorites_count")
  final int favoritesCount;
  final String? author;
  final String body;

  const QuoteResponse({
    required this.id,
    required this.favoritesCount,
    required this.author,
    required this.body,
  });

  factory QuoteResponse.fromJson(Map<String, dynamic> json) =>
      _$QuoteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteResponseToJson(this);
}

extension QuoteResponseToQuoteCardViewModel on QuoteResponse {
  QuoteCardViewModel toQuoteCardViewModel() {
    String favoritesCount = this.favoritesCount > 1
        ? "${this.favoritesCount} favs"
        : "${this.favoritesCount} fav";
    return QuoteCardViewModel(
      favoritesCount: favoritesCount,
      author: author,
      body: body,
    );
  }
}
