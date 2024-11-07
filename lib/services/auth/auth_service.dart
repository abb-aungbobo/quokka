import 'package:quokka/models/network/requests/login_request/login_request.dart';
import 'package:quokka/models/network/responses/login_response/login_response.dart';
import 'package:quokka/models/network/responses/logout_response/logout_response.dart';

abstract class AuthService {
  Future<LoginResponse> login({required LoginRequest request});
  Future<LogoutResponse> logout();
}
