import 'package:flutter/material.dart';
import 'package:olearis_test/ui/login/login_screen.dart';
import 'package:olearis_test/ui/main/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      routes: {
        MainScreen.routeName: (context) => const MainScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
      },
    ),
  );
}
