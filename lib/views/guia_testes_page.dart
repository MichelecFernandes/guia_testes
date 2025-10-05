import 'package:flutter/material.dart';
import 'package:login_exercicio/models/guide_topic.dart';
import 'package:login_exercicio/providers/user_notifier.dart';
import 'package:login_exercicio/controllers/auth_controller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GuiaTestesPage extends StatefulWidget {
  const GuiaTestesPage({super.key});

  @override
  State<GuiaTestesPage> createState() => _GuiaTestesPageState();
}

class _GuiaTestesPageState extends State<GuiaTestesPage> {

  final List<GuideTopic> _guideTopics = [
    GuideTopic(
      title: 'Testes Unitários', 
      link: 'https://aws.amazon.com/pt/what-is/unit-testing/', 
      description: 'Testa funções isoladas de código para garantir que cada parte da sua lógica funcione corretamente.',
      courses: [
        CourseLink(title: 'TDD em Flutter com BLoC', url: 'https://www.udemy.com/course/flutter-tdd-clean-architecture/'),
        CourseLink(title: 'Dominando o Teste Unitário (JS)', url: 'https://www.udemy.com/course/javascript-testing-unit-functional-e2e/'),
        CourseLink(title: 'Testes Unitários com JUnit', url: 'https://www.alura.com.br/curso-online-java-junit-testes-unitarios'),
      ],
    )
  ];

  @override
  void initState() {
    super.initState();
  }

  void _logout(BuildContext context) async {
    final navigator = Navigator.of(context);
    await AuthController.instance.logout();
    context.read<UserNotifier>().clearUser();
    navigator.pushReplacementNamed('/home');
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível abrir o link.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserNotifier>().user;
    final userName = user?.firstName ?? 'Usuário';
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Guia de Testes de Software'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
            tooltip: 'Sair',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bem-vindo(a), $userName!',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Selecione um tópico abaixo para acessar o guia de testes:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _guideTopics.length,
                itemBuilder: (context, index) {
                  final item = _guideTopics[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => _launchUrl(item.link),
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.title,
                                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Icon(Icons.link, size: 20, color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                          const Divider(),
                          Text(
                            item.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Sugestões de Cursos:',
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...item.courses.map((course) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: InkWell(
                              onTap: () => _launchUrl(course.url),
                              borderRadius: BorderRadius.circular(8),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.school, size: 18, color: primaryColor),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        course.title,
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          decoration: TextDecoration.underline,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                                  ],
                                ),
                              ),
                            ),
                          )).toList(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}