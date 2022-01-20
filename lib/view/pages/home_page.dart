import 'package:auth_app/core/models/user_model.dart';
import 'package:auth_app/core/navigation/navigation_manager.gr.dart';
import 'package:auth_app/core/repositories/auth_repository.dart';
import 'package:auth_app/core/view_models/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [logOutButton(context)],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.user != null) {
            User _user = state.user!;
            return Text(_user.mail!);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  BlocListener<AuthBloc, AuthState> logOutButton(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          context.router.replaceAll([const LoginRoute()]);
        }
      },
      child: IconButton(
        onPressed: () => context.read<AuthBloc>().add(
            AuthLogoutRequested()), // çıkış yapma işlemi için Bu eventi tetikliyoruz.
        icon: const Icon(
          Icons.exit_to_app,
        ),
        splashRadius: 18,
      ),
    );
  }
}
