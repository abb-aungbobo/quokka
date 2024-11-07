import 'package:dio/dio.dart';
import 'package:quokka/configuration/environment.dart';
import 'package:quokka/models/network/requests/login_request/login_request.dart';
import 'package:quokka/models/network/responses/login_response/login_response.dart';
import 'package:quokka/models/network/responses/logout_response/logout_response.dart';
import 'package:quokka/models/network/responses/qotd_response/qotd_response.dart';
import 'package:quokka/models/network/responses/quote_list_response/quote_list_response.dart';
import 'package:quokka/network/endpoint/quotes_endpoint.dart';
import 'package:quokka/network/endpoint/session_endpoint.dart';
import 'package:retrofit/retrofit.dart';

part 'network_client.g.dart';

@RestApi(baseUrl: Environment.apiBaseUrl)
abstract class NetworkClient {
  factory NetworkClient(Dio dio) = _NetworkClient;

  @POST(SessionEndpoint.session)
  Future<LoginResponse> login(@Body() LoginRequest request);

  @DELETE(SessionEndpoint.session)
  Future<LogoutResponse> logout();

  @GET(QuotesEndpoint.qotd)
  Future<QotdResponse> getQuoteOfTheDay();

  @GET(QuotesEndpoint.quotes)
  Future<QuoteListResponse> getQuotes(@Query("filter") String filter);
}
