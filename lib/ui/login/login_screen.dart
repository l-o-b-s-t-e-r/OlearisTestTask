import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olearis_test/bloc/login/login_bloc.dart';
import 'package:olearis_test/bloc/login/login_events.dart';
import 'package:olearis_test/bloc/login/login_state.dart';
import 'package:olearis_test/extensions.dart';
import 'package:olearis_test/ui/login/login_form.dart';
import 'package:olearis_test/ui/main/main_screen.dart';
import 'package:olearis_test/ui/widgets/sign_in_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(
        listenWhen: (prevState, newState) => newState.status.isSuccess,
        listener: (context, state) {
          Navigator.pushReplacementNamed(context, MainScreen.routeName);
        },
        child: const LoginContent(),
      ),
    );
  }
}

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  void onSignInPressed(BuildContext context) {
    context.read<LoginBloc>().add(SignInEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: context.isPortrait
              ? PortraitLoginContent(
                  onSignInPressed: () => onSignInPressed(context),
                )
              : LandscapeLoginContent(
                  onSignInPressed: () => onSignInPressed(context),
                ),
        ),
      ),
    );
  }
}

class PortraitLoginContent extends StatelessWidget {
  const PortraitLoginContent({required this.onSignInPressed, super.key});

  final VoidCallback onSignInPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: SizedBox(
            height: constraints.maxHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Spacer(),
                const Image(image: AssetImage('images/logo.png')),
                const Spacer(),
                LoginForm(state: context.read<LoginBloc>().state),
                const Spacer(flex: 2),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) => SignInButton(
                    isLoading: state.status.isLoading || state.status.isSuccess,
                    isEnabled: state.isLoginEnabled,
                    onPressed: onSignInPressed,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LandscapeLoginContent extends StatelessWidget {
  const LandscapeLoginContent({required this.onSignInPressed, super.key});

  final VoidCallback onSignInPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Image(
            image: AssetImage('images/logo.png'),
            height: 160,
          ),
          LoginForm(state: context.read<LoginBloc>().state),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) => SignInButton(
              isLoading: state.status.isLoading || state.status.isSuccess,
              isEnabled: state.isLoginEnabled,
              onPressed: onSignInPressed,
            ),
          ),
        ],
      ),
    );
  }
}
