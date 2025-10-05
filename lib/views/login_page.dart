import 'package:flutter/material.dart';
import 'package:login_exercicio/shared/app_constants.dart';
import 'package:login_exercicio/components/custom_text_field.dart';
import 'package:login_exercicio/components/app_button.dart';
import 'package:login_exercicio/components/custom_snack_bar.dart';
import 'package:login_exercicio/controllers/auth_controller.dart';
import 'package:login_exercicio/providers/user_notifier.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true;

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

Future<void> _login() async {
  if (!_formKey.currentState!.validate() || _isLoading) return;
  
  setState(() => _isLoading = true);

  final navigator = Navigator.of(context);
  final messenger = ScaffoldMessenger.of(context);
  final userNotifier = context.read<UserNotifier>();

  bool success = await AuthController.instance.login(
    _userNameController.text,
    _passwordController.text,
  );
  
  setState(() => _isLoading = false);

  if (success) {
    await userNotifier.loadUser(); 
    navigator.pushReplacementNamed('/guia'); 
  } else {
    messenger.showSnackBar(
      customSnackBar(
        message: 'Credenciais inválidas. Tente novamente.',
        backgroundColor: const Color.fromARGB(255, 87, 20, 20),
        icon: Icons.error_outline,
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(AppConstants.appLoginMsg, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 32.0),
                    CustomTextField(
                      label: 'Usuário',
                      hint: 'Usuário de acesso ao sistema',
                      controller: _userNameController,
                      prefixIcon: const Icon(Icons.person_2_outlined),
                      validator: (username) => username == null || username.isEmpty ? 'Preencha o campo do usuário' : null,
                      onFieldSubmitted: (_) => _login(),
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextField(
                      label: 'Senha',
                      hint: 'Digite sua senha',
                      controller: _passwordController,
                      prefixIcon: const Icon(Icons.lock),
                      obscureText: _obscureText,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                      ),
                      validator: (password) => password == null || password.isEmpty ? 'Preencha o campo senha' : null,
                      onFieldSubmitted: (_) => _login(),
                    ),
                    const SizedBox(height: 16.0),
                    AppButton(
                      text: 'Entrar',
                      onPressed: _login,
                      isLoading: _isLoading,
                    ),
                    const SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushReplacementNamed('/home'), 
                      child: const Text('Voltar para a Home'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}