import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quokka/app_router/app_router.dart';
import 'package:quokka/models/network/responses/quote_response/quote_response.dart';
import 'package:quokka/screens/qotd/qotd_cubit.dart';
import 'package:quokka/ui_component/error_dialog/error_dialog.dart';
import 'package:quokka/ui_component/loading_indicator/loading_indicator.dart';
import 'package:quokka/ui_component/quote_card_view/quote_card_view.dart';

class QotdBlocProvider extends StatelessWidget {
  const QotdBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QotdCubit()..getQuoteOfTheDay(),
      child: const QotdScreen(),
    );
  }
}

class QotdScreen extends StatelessWidget {
  const QotdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<QotdCubit, QotdState>(
      listener: (context, state) {
        if (state.error != null) {
          showErrorDialog(context, error: state.error).then((_) {
            if (context.mounted) {
              context.read<QotdCubit>().clearError();
            }
          });
        }
        if (state.isLoggedOut) {
          context.replaceNamed(RouteName.login);
        }
      },
      child: BlocBuilder<QotdCubit, QotdState>(
        builder: (context, state) {
          return _buildScaffold(context, state: state);
        },
      ),
    );
  }

  Widget _buildScaffold(
    BuildContext context, {
    required QotdState state,
  }) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quokka"),
        leading: IconButton(
          icon: Icon(
            Icons.logout,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            _showLogoutDialog(context, onLogout: () {
              context.read<QotdCubit>().logout();
            });
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              context.pushNamed(RouteName.quote_search);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildQotd(context, state: state),
          if (state.isLoading) const LoadingIndicator(),
        ],
      ),
    );
  }

  Widget _buildQotd(
    BuildContext context, {
    required QotdState state,
  }) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: Text(
            "Quote of the Day",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        if (state.quote != null)
          QuoteCardView(
            viewModel: state.quote!.toQuoteCardViewModel(),
          ),
      ],
    );
  }

  Future<void> _showLogoutDialog(
    BuildContext context, {
    required Function() onLogout,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: onLogout,
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}
