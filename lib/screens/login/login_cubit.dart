import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quokka/locator/locator.dart';
import 'package:quokka/models/network/requests/login_request/login_request.dart';
import 'package:quokka/models/network/requests/user_request/user_request.dart';
import 'package:quokka/secure_storage/secure_storage.dart';
import 'package:quokka/secure_storage/secure_storage_key.dart';
import 'package:quokka/services/auth/auth_service.dart';

class LoginCubit extends Cubit<LoginState> {
  final _authService = locator<AuthService>();
  final _secureStorage = locator<SecureStorage>();

  LoginCubit() : super(LoginState());

  void clearError() {
    emit(
      state.copyWith(error: null),
    );
  }

  void updateLogin(String login) {
    emit(
      state.copyWith(login: login),
    );
  }

  void updatePassword(String password) {
    emit(
      state.copyWith(password: password),
    );
  }

  void login() async {
    emit(
      state.copyWith(isLoading: true),
    );
    try {
      final request = LoginRequest(
        user: UserRequest(
          login: state.login,
          password: state.password,
        ),
      );
      final response = await _authService.login(request: request);
      _secureStorage.write(
        value: response.userToken,
        key: SecureStorageKey.userToken,
      );
      emit(
        state.copyWith(isLoading: false, isLoggedIn: true),
      );
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, error: e),
      );
    }
  }
}

class LoginState {
  final bool isLoading;
  final Object? error;
  final String login;
  final String password;
  final bool isLoggedIn;

  bool get isLoginButtonEnabled {
    final isValidLogin = login.trim().isNotEmpty;
    final isValidPassword = password.trim().isNotEmpty;
    return isValidLogin && isValidPassword;
  }

  const LoginState({
    this.isLoading = false,
    this.error,
    this.login = "",
    this.password = "",
    this.isLoggedIn = false,
  });

  LoginState copyWith({
    bool? isLoading,
    Object? error,
    String? login,
    String? password,
    bool? isLoggedIn,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      login: login ?? this.login,
      password: password ?? this.password,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}
