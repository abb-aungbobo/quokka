import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quokka/locator/locator.dart';
import 'package:quokka/models/network/responses/quote_response/quote_response.dart';
import 'package:quokka/secure_storage/secure_storage.dart';
import 'package:quokka/services/auth/auth_service.dart';
import 'package:quokka/services/quote/quote_service.dart';

class QotdCubit extends Cubit<QotdState> {
  final _quoteService = locator<QuoteService>();
  final _authService = locator<AuthService>();
  final _secureStorage = locator<SecureStorage>();

  QotdCubit() : super(QotdState());

  void clearError() {
    emit(
      state.copyWith(error: null),
    );
  }

  void getQuoteOfTheDay() async {
    emit(
      state.copyWith(isLoading: true),
    );
    try {
      final qotd = await _quoteService.getQuoteOfTheDay();
      emit(
        state.copyWith(isLoading: false, quote: qotd.quote),
      );
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, error: e),
      );
    }
  }

  void logout() async {
    emit(
      state.copyWith(isLoading: true),
    );
    try {
      await _authService.logout();
      _secureStorage.deleteAll();
      emit(
        state.copyWith(isLoading: false, isLoggedOut: true),
      );
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, error: e),
      );
    }
  }
}

class QotdState {
  final bool isLoading;
  final Object? error;
  final QuoteResponse? quote;
  final bool isLoggedOut;

  const QotdState({
    this.isLoading = false,
    this.error,
    this.quote,
    this.isLoggedOut = false,
  });

  QotdState copyWith({
    bool? isLoading,
    Object? error,
    QuoteResponse? quote,
    bool? isLoggedOut,
  }) {
    return QotdState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      quote: quote ?? this.quote,
      isLoggedOut: isLoggedOut ?? this.isLoggedOut,
    );
  }
}
