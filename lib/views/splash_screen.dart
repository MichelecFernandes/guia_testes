import 'package:flutter/material.dart';
import 'package:login_exercicio/controllers/auth_controller.dart';
import 'package:login_exercicio/providers/user_notifier.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    await Future.delayed(const Duration(milliseconds: 1500)); 
    bool hasValidToken = await AuthController.instance.verifyToken();
    if (hasValidToken) {
      await context.read<UserNotifier>().loadUser();
    }
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(
      hasValidToken && context.read<UserNotifier>().user != null
          ? '/guia'
          : '/home',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Theme.of(context).primaryColor),
            const SizedBox(height: 16.0),
            const Text("Verificando sessão..."),
          ],
        ),
      ),
    );
  }
}