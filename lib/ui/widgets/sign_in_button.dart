import 'package:flutter/material.dart';
import 'package:olearis_test/extensions.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    required this.isLoading,
    required this.isEnabled,
    required this.onPressed,
    super.key,
  });

  final bool isLoading, isEnabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colors.primary,
            foregroundColor: context.colors.onPrimary,
          ),
          child: Visibility(
            visible: !isLoading,
            maintainSize: true,
            maintainState: true,
            maintainAnimation: true,
            child: const Text('Continue'),
          ),
        ),
        Visibility(
          visible: isLoading,
          child: SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              backgroundColor: context.colors.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
