import 'package:auth_app/core/constants/navigation_consts.dart';
import 'package:auth_app/core/navigation/navigation_manager.gr.dart';
import 'package:auth_app/core/repositories/auth_repository.dart';
import 'package:auth_app/core/view_models/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _mailController,
                validator: null, // isteğe göre validator belirleyebilirsiniz.
              ),
              TextFormField(
                controller: _passwordController,
                validator: null,
                obscureText: true,
              ),
              BlocListener<AuthBloc, AuthState>(
                // oturum açma işleminde olacak bir değişikliği bu BlocListener ile dinliyoruz.
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status == AuthStatus.authenticated) {
                    context.router.replace(
                        const HomeRoute()); // Eğer oturum açılırsa BlocListener bizi HomePage e gönderiyor.
                  }
                },
                child: loginButton(_formKey, context),
              ),
              registerButton
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton get registerButton {
    return ElevatedButton(
        onPressed: () {
          context.router.navigateNamed(RouteConsts.REGISTER_PAGE);
        },
        child: const Text('Register Page'));
  }

  ElevatedButton loginButton(
      GlobalKey<FormState> _formKey, BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            BlocProvider.of<AuthBloc>(context).add(AuthLoginRequested(
                //Bu eventimiz mail ve password parametrelerini istiyordu.
                _mailController.text,
                _passwordController.text));
          }
        },
        child: const Text('Login'));
  }
}
