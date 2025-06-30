import 'package:flutter/material.dart';
//import '../modules/auth/pages/login_page.dart';
//import '../modules/dashboard/pages/dashboard_page.dart';

abstract class AppRoutes {
  static const login = '/login';
  static const dashboard = '/dashboard';

  static final routes = <String, WidgetBuilder>{
    //login: (context) => const LoginPage(),
    //dashboard: (context) => const DashboardPage(),
  };
}
