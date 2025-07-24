import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/app/core/providers/auth_provider.dart';
import 'package:flutter_app/app/modules/dashboard/pages/dashboard_page.dart';
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
    return ChangeNotifierProvider(
      create: (context) => AuthProvider()..loadSession(),
      child: MaterialApp(
        title: 'Certeira',
        debugShowCheckedModeBanner: false,
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return authProvider.isLoggedIn
                ? const DashboardPage()
                : const LoginPage();
          },
        ),
      ),
    );
  }
}
