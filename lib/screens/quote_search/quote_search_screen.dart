import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quokka/models/network/responses/quote_response/quote_response.dart';
import 'package:quokka/screens/quote_search/quote_search_cubit.dart';
import 'package:quokka/ui_component/error_dialog/error_dialog.dart';
import 'package:quokka/ui_component/loading_indicator/loading_indicator.dart';
import 'package:quokka/ui_component/quote_card_view/quote_card_view.dart';

class QuoteSearchBlocProvider extends StatelessWidget {
  const QuoteSearchBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuoteSearchCubit(),
      child: const QuoteSearchScreen(),
    );
  }
}

class QuoteSearchScreen extends StatefulWidget {
  const QuoteSearchScreen({super.key});

  @override
  State<QuoteSearchScreen> createState() => _QuoteSearchScreenState();
}

class _QuoteSearchScreenState extends State<QuoteSearchScreen> {
  final _searchController = SearchController();
  final _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuoteSearchCubit, QuoteSearchState>(
      listener: (context, state) {
        if (state.error != null) {
          showErrorDialog(context, error: state.error).then((_) {
            if (context.mounted) {
              context.read<QuoteSearchCubit>().clearError();
            }
          });
        }
      },
      child: BlocBuilder<QuoteSearchCubit, QuoteSearchState>(
        builder: (context, state) {
          return _buildScaffold(context, state: state);
        },
      ),
    );
  }

  Widget _buildScaffold(
    BuildContext context, {
    required QuoteSearchState state,
  }) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              _buildSearchBar(context),
              _buildList(context, state: state),
            ],
          ),
          if (state.isLoading) const LoadingIndicator(),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SearchBar(
        controller: _searchController,
        focusNode: _searchFocusNode,
        hintText: "Search",
        trailing: [
          if (_searchController.text.isNotEmpty && _searchFocusNode.hasFocus)
            IconButton(
              icon: Icon(
                Icons.clear,
              ),
              onPressed: () {
                _searchController.clear();
                _searchFocusNode.unfocus();
                context.read<QuoteSearchCubit>().searchQuotes(filter: "");
              },
            ),
        ],
        onChanged: (value) {
          context.read<QuoteSearchCubit>().searchQuotes(filter: value);
        },
        autoFocus: true,
      ),
    );
  }

  Widget _buildList(
    BuildContext context, {
    required QuoteSearchState state,
  }) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.quotes.length,
        itemBuilder: (context, index) {
          final quote = state.quotes[index];
          return QuoteCardView(
            viewModel: quote.toQuoteCardViewModel(),
          );
        },
      ),
    );
  }
}
