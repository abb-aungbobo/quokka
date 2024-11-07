import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quokka/locator/locator.dart';
import 'package:quokka/models/network/responses/quote_response/quote_response.dart';
import 'package:quokka/services/quote/quote_service.dart';

class QuoteSearchCubit extends Cubit<QuoteSearchState> {
  final _quoteService = locator<QuoteService>();

  QuoteSearchCubit() : super(QuoteSearchState());

  void clearError() {
    emit(
      state.copyWith(error: null),
    );
  }

  void searchQuotes({required String filter}) async {
    if (filter.isEmpty) {
      emit(
        state.copyWith(quotes: []),
      );
      return;
    }
    emit(
      state.copyWith(isLoading: true),
    );
    try {
      final result = await _quoteService.getQuotes(filter: filter);
      final quotes = result.quotes
          .where((quote) => quote.body != "No quotes found")
          .toList();
      emit(
        state.copyWith(isLoading: false, quotes: quotes),
      );
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, error: e),
      );
    }
  }
}

class QuoteSearchState {
  final bool isLoading;
  final Object? error;
  final List<QuoteResponse> quotes;

  const QuoteSearchState({
    this.isLoading = false,
    this.error,
    this.quotes = const [],
  });

  QuoteSearchState copyWith({
    bool? isLoading,
    Object? error,
    List<QuoteResponse>? quotes,
  }) {
    return QuoteSearchState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      quotes: quotes ?? this.quotes,
    );
  }
}
