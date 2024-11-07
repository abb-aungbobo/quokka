import 'package:quokka/locator/locator.dart';
import 'package:quokka/models/network/requests/login_request/login_request.dart';
import 'package:quokka/models/network/responses/login_response/login_response.dart';
import 'package:quokka/models/network/responses/logout_response/logout_response.dart';
import 'package:quokka/network/network_client/network_client.dart';
import 'package:quokka/services/auth/auth_service.dart';

class AuthServiceImpl implements AuthService {
  final _networkClient = locator<NetworkClient>();

  @override
  Future<LoginResponse> login({required LoginRequest request}) =>
      _networkClient.login(request);

  @override
  Future<LogoutResponse> logout() => _networkClient.logout();
}
