import 'package:quokka/models/network/responses/qotd_response/qotd_response.dart';
import 'package:quokka/models/network/responses/quote_list_response/quote_list_response.dart';

abstract class QuoteService {
  Future<QotdResponse> getQuoteOfTheDay();
  Future<QuoteListResponse> getQuotes({required String filter});
}
