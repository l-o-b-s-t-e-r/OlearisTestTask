import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olearis_test/bloc/login/login_bloc.dart';
import 'package:olearis_test/bloc/login/login_events.dart';
import 'package:olearis_test/bloc/login/login_state.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({required this.state, super.key});

  final LoginState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: TextEditingController(text: state.login),
          decoration: const InputDecoration(labelText: 'Login'),
          onChanged: (text) {
            context.read<LoginBloc>().add(UpdateLoginEvent(login: text));
          },
        ),
        TextField(
          controller: TextEditingController(text: state.password),
          decoration: const InputDecoration(labelText: 'Password'),
          onChanged: (text) {
            context.read<LoginBloc>().add(UpdatePasswordEvent(password: text));
          },
        ),
      ],
    );
  }
}
