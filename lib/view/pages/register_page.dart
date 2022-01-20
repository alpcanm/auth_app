import 'package:auth_app/core/repositories/auth_repository.dart';
import 'package:auth_app/core/utils/locator_get_it.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Page'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _nameController,
          ),
          TextFormField(
            controller: _surnameController,
          ),
          TextFormField(
            controller: _mailController,
          ),
          TextFormField(
            controller: _passwordController,
          ),
          TextButton(
              onPressed: () {
                getIt<AuthRepository>().signUp(// Bu işlem herhangi bir state değiştirmediği için direkt olarak get_it ile çekiyoruz.
                    name: _nameController.text,
                    surname: _surnameController.text,
                    mail: _mailController.text,
                    password: _passwordController.text);
              },
              child: const Text('Submit'))
        ],
      ),
    );
  }
}
