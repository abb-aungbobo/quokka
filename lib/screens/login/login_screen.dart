import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quokka/app_router/app_router.dart';
import 'package:quokka/screens/login/login_cubit.dart';
import 'package:quokka/ui_component/error_dialog/error_dialog.dart';
import 'package:quokka/ui_component/loading_indicator/loading_indicator.dart';

class LoginBlocProvider extends StatelessWidget {
  const LoginBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.error != null) {
          showErrorDialog(context, error: state.error).then((_) {
            if (context.mounted) {
              context.read<LoginCubit>().clearError();
            }
          });
        }
        if (state.isLoggedIn) {
          context.replaceNamed(RouteName.qotd);
        }
      },
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return _buildScaffold(context, state: state);
        },
      ),
    );
  }

  Widget _buildScaffold(
    BuildContext context, {
    required LoginState state,
  }) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quokka"),
      ),
      body: Stack(
        children: [
          _buildForm(context, state: state),
          if (state.isLoading) const LoadingIndicator(),
        ],
      ),
    );
  }

  Widget _buildForm(
    BuildContext context, {
    required LoginState state,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Username or Email",
            ),
            autocorrect: false,
            onChanged: (value) {
              context.read<LoginCubit>().updateLogin(value);
            },
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Password",
            ),
            obscureText: true,
            autocorrect: false,
            onChanged: (value) {
              context.read<LoginCubit>().updatePassword(value);
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: state.isLoginButtonEnabled
                ? () => context.read<LoginCubit>().login()
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              minimumSize: const Size(double.infinity, 40),
            ),
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}
