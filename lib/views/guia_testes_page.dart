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
    GuideTopic(title: 'Testes Unitários', link: 'https://aws.amazon.com/pt/what-is/unit-testing/', description: 'Testa funções isoladas de código.'),
    GuideTopic(title: 'Teste de Integração', link: 'https://www.ibm.com/br-pt/think/topics/integration-testing', description: 'Verifica a comunicação entre diferentes componentes.'),
    GuideTopic(title: 'Teste de Carga', link: 'https://voidr.co/blog/teste-de-carga/', description: 'Avalia o desempenho sob condições de alto volume.'),
    GuideTopic(title: 'Teste de E2E (End-to-End)', link: 'https://circleci.com/blog/what-is-end-to-end-testing/', description: 'Simula a jornada completa do usuário no aplicativo.'),
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
                color: Theme.of(context).primaryColor,
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
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(15),
                      title: Text(
                        item.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        item.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () => _launchUrl(item.link),
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