import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // 👇 The first page that opens when the app starts
      home: const LoginPage(),

      // 👇 Define named routes so you can navigate between pages easily
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
      },
    );
  }
}
