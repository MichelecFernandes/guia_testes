import 'package:flutter/material.dart';
import 'package:guia_testes/models/guide_topic.dart';
import 'package:guia_testes/providers/user_notifier.dart';
import 'package:guia_testes/controllers/auth_controller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GuideTestsPage extends StatefulWidget {
  const GuideTestsPage({super.key});

  @override
  State<GuideTestsPage> createState() => _GuideTestsPageState();
}

class _GuideTestsPageState extends State<GuideTestsPage> {
  final List<GuideTopic> _guideTopics = [
    GuideTopic(
      title: 'Testes Unitários',
      link: 'https://aws.amazon.com/pt/what-is/unit-testing/',
      description:
          'Testa funções isoladas de código para garantir que cada parte da sua lógica funcione corretamente.',
      courses: [
        CourseLink(
          title: 'Testes unitários com JUnit 5',
          url: 'https://www.udemy.com/course/testes-unitarios-junit5/',
        ),
        CourseLink(
          title: 'Curso de Teste Unitário: O que é teste unitário?',
          url: 'https://www.youtube.com/watch?v=3xeg-wXC1o8',
        ),
        CourseLink(
          title: 'Curso Node.js: testes unitários e de integração',
          url:
              'https://www.alura.com.br/curso-online-nodejs-testes-unitarios-integracao?srsltid=AfmBOop_5dYffVLvNYxTEYFZUtia2Ip4jN-Jv_1-nhkaY7B5g9KTPb7Q',
        ),
      ],
    ),
    GuideTopic(
      title: 'Teste de Integração',
      link: 'https://www.ibm.com/br-pt/think/topics/integration-testing',
      description:
          'Verifica a comunicação e o fluxo de dados entre diferentes módulos e serviços do sistema.',
      courses: [
        CourseLink(
          title: 'Integração Contínua com testes, utilizando Jenkins',
          url:
              'https://www.cod3r.com.br/courses/integracao-continua-com-testes-utilizando-jenkins',
        ),
        CourseLink(
          title: 'Testes de Integração em Java',
          url: 'https://www.alura.com.br/curso-online-testes-integracao-java',
        ),
        CourseLink(
          title: 'Flutter: dominando testes de integração',
          url:
              'https://www.alura.com.br/curso-online-flutter-dominando-testes-integracao',
        ),
      ],
    ),
    GuideTopic(
      title: 'Teste de Carga',
      link: 'https://voidr.co/blog/teste-de-carga/',
      description:
          'Avalia o desempenho e a estabilidade do sistema sob condições de alto volume de usuários ou dados.',
      courses: [
        CourseLink(
          title: 'Integração Contínua: Rollback e teste de carga',
          url:
              'https://www.alura.com.br/curso-online-integracao-continua-rollback-teste-carga?srsltid=AfmBOopY93x34BGH9pF0ihhftX7HvkY276NxfNrInTuVTc_kRH4cMCSk',
        ),
        CourseLink(
          title: 'JMeter - Testes de performance',
          url:
              'https://www.udemy.com/course/testes-de-performance-com-jmeter-basico-ao-avancado/',
        ),
        CourseLink(
          title: 'Teste de performance com K6',
          url:
              'https://www.udemy.com/course/teste-de-performance-com-k6/?srsltid=AfmBOopxKlCqmniXFSKyy47tYLKKU4UcLkNaiNbNNsRGPF95riqA5n9w',
        ),
      ],
    ),
    GuideTopic(
      title: 'Teste de E2E (End-to-End)',
      link: 'https://circleci.com/blog/what-is-end-to-end-testing/',
      description:
          'Simula a jornada completa do usuário no aplicativo, garantindo que o fluxo de negócios funcione.',
      courses: [
        CourseLink(
          title: 'Introdução aos Testes End-to-End (E2E) com Cypress',
          url:
              'https://www.dio.me/articles/introducao-aos-testes-end-to-end-e2e-com-cypress',
        ),
        CourseLink(
          title: 'Cypress: automatizando testes E2E',
          url:
              'https://www.alura.com.br/curso-online-cypress-automatizando-testes-e2e?srsltid=AfmBOooADjLdOgBzns6ors8ZMx_aAXaiAYpAbtfWoCZp3yG2-Oltb1Sj',
        ),
        CourseLink(
          title: 'iOS: trabalhando testes E2E com Maestro',
          url:
              'https://www.alura.com.br/curso-online-ios-trabalhando-testes-e2e-maestro?srsltid=AfmBOoqEfcBWLerbP5o0UG9yl_t2LviRNmsXcq4ZiYZ9AlWQqCpzyHGZ',
        ),
      ],
    ),
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
    final primaryColor = const Color.fromARGB(255, 2, 45, 80);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 2, 45, 80),
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
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.link,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
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
                            style: Theme.of(context).textTheme.titleSmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).hintColor,
                                ),
                          ),
                          const SizedBox(height: 8),
                          ...item.courses
                              .map(
                                (course) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: InkWell(
                                    onTap: () => _launchUrl(course.url),
                                    borderRadius: BorderRadius.circular(8),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4.0,
                                        horizontal: 4.0,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.school,
                                            size: 18,
                                            color: primaryColor,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              course.title,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: primaryColor,
                                                  ),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 14,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
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
