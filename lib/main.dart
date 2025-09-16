
import 'package:flutter/material.dart';
import 'package:login_exercicio/shared/app_constants.dart';
import 'package:login_exercicio/shared/app_theme.dart';
import 'package:login_exercicio/views/home_page.dart';
import 'package:login_exercicio/views/login_page.dart';

void main() {
  runApp(MyApp());
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
        '/': (context) => HomePage(),
        '/login': (context) => LoginPage()
      },
    );
  }
}

