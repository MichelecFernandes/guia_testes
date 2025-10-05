import 'package:flutter/material.dart';
import 'package:login_exercicio/providers/user_notifier.dart';
import 'package:login_exercicio/shared/app_constants.dart';
import 'package:login_exercicio/shared/app_theme.dart';
import 'package:login_exercicio/views/home_page.dart';
import 'package:login_exercicio/views/login_page.dart';
import 'package:login_exercicio/views/splash_screen.dart';
import 'package:login_exercicio/views/guia_testes_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage()
      },
    );
  }
}