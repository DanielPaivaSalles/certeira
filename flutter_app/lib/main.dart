import 'package:flutter/material.dart';
import 'app/core/helpers/screen_helper.dart';
import 'app/modules/auth/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ScreenHelper.maximizarWindow();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Certeira',
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
