
import 'package:flutter_frontend/ui/pages/auth/login_page.dart';
import 'package:flutter_frontend/ui/pages/main_page.dart';
import 'package:flutter_frontend/ui/pages/auth/register_page.dart';

enum MyRoute {
  login('/login'),
  home('/home'),
  register('/register');

  final String name;
  const MyRoute(this.name);
}

final routes = {
  MyRoute.login.name: (context) => const LoginPage(),
  MyRoute.register.name: (context) => RegisterPage(),
  MyRoute.home.name: (context) => const MainPage(),
};