import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/helpers/screen_helper.dart';
import 'package:flutter_app/app/modules/auth/controllers/login_controller.dart';
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
  final LoginController loginController = LoginController();

  String mensagem = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScreenHelper.maximizarWindow();
    });
  }

  Future<void> _fazerLogin() async {
    final response = await loginController.fazerLogin(
      emailController.text,
      senhaController.text,
    );

    if (!mounted) return;

    if (response.status) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    } else {
      setState(() {
        mensagem = 'Erro: ${response.mensagem}';
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
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                labelText: 'Email',
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
                              obscureText: true,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                labelText: 'Senha',
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
                                  onTap: _fazerLogin,
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
