import 'package:quokka/locator/locator.dart';
import 'package:quokka/models/network/responses/qotd_response/qotd_response.dart';
import 'package:quokka/models/network/responses/quote_list_response/quote_list_response.dart';
import 'package:quokka/network/network_client/network_client.dart';
import 'package:quokka/services/quote/quote_service.dart';

class QuoteServiceImpl implements QuoteService {
  final _networkClient = locator<NetworkClient>();

  @override
  Future<QotdResponse> getQuoteOfTheDay() => _networkClient.getQuoteOfTheDay();

  @override
  Future<QuoteListResponse> getQuotes({required String filter}) =>
      _networkClient.getQuotes(filter);
}
