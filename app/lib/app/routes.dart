import 'package:flutter/material.dart';

import '../features/auth/screens/login_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/pro/pro_landing/screens/pro_landing_screen.dart';

import '../features/client/client_home/screens/client_home_screen.dart';

import '../core/guards/auth_guard.dart';


class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';

  static const String clientHome = '/client-home';
  static const String proLanding = '/pro';

  static Map<String, WidgetBuilder> get routes => {
    home: (context) => const HomeScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
 
    clientHome: (context) => const AuthGuard(child: ClientHomeScreen()),
    proLanding: (context) => const ProLandingScreen(),
  };
}
