import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/helpers/screen_helper.dart';
import 'package:http/http.dart' as http;
import '../../dashboard/pages/dashboard_page.dart';
import '../../../core/widgets/custom_buttom.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  String mensagem = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScreenHelper.maximizarWindow();
    });
  }

  Future<void> fazerLogin() async {
    final url = Uri.parse('http://localhost:8080/empregadoLogin');

    final resposta = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': 'danielpaivasalles@gmail.com', //emailController.text,
        'senha': '530337503b614a@D', //senhaController.text,
      }),
    );

    if (resposta.statusCode == 200) {
      final json = jsonDecode(resposta.body);
      if (json['status'] == true) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
      } else {
        setState(() {
          mensagem = 'Erro: ${json['mensagem']}';
        });
      }
    } else {
      setState(() {
        mensagem = 'Erro na conexão: ${resposta.statusCode}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(100),
                              color: Colors.amber,
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: emailController,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'email',
                                labelStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: senhaController,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'senha',
                                labelStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomButton(
                                  label: 'Entrar',
                                  isSelected: false,
                                  onTap: fazerLogin,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              mensagem,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
