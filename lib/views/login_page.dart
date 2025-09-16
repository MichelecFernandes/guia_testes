import 'package:flutter/material.dart';
import 'package:login_exercicio/shared/app_constants.dart';
import 'package:login_exercicio/components/custom_text_field.dart';
import 'package:login_exercicio/components/app_button.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(AppConstants.appLoginMsg, textAlign: TextAlign.center),
              const SizedBox(height: 32.0),
              CustomTextField(
                label: 'Usuário',
                hint: 'Usuário de acesso ao sistema',
                controller: _userNameController,
                prefixIcon: Icon(Icons.person_2_outlined),
                validator: (username) {
                  if (username == null || username.isEmpty) {
                    return 'Preencha o campo do usuário';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16.0),
              CustomTextField(label: 'Senha',
              hint: 'Digite sua senha',
              controller: _passwordController,
              prefixIcon: Icon(Icons.lock),
              obscureText: true,),
              const SizedBox(height: 16.0),
              AppButton(text: 'Entrar', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
