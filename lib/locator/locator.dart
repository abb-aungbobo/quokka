import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:quokka/configuration/environment.dart';
import 'package:quokka/network/network_client/network_client.dart';
import 'package:quokka/secure_storage/secure_storage.dart';
import 'package:quokka/services/auth/auth_service.dart';
import 'package:quokka/services/auth/auth_service_impl.dart';
import 'package:quokka/services/quote/quote_service.dart';
import 'package:quokka/services/quote/quote_service_impl.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  _registerNetworkClient();
  _registerSecureStorage();
  _registerServices();
}

void _registerNetworkClient() {
  final Dio dio = Dio();
  dio.options.headers = {"Authorization": Environment.apiKey};
  dio.options.contentType = "application/json";
  locator.registerLazySingleton<NetworkClient>(() => NetworkClient(dio));
}

void _registerSecureStorage() {
  locator.registerLazySingleton<SecureStorage>(() => SecureStorage());
}

void _registerServices() {
  locator.registerFactory<AuthService>(() => AuthServiceImpl());
  locator.registerFactory<QuoteService>(() => QuoteServiceImpl());
}
