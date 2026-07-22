import 'package:flutter/material.dart';

import '../features/auth/screens/login_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/auth/screens/register_screen.dart';

import '../core/guards/auth_guard.dart';
import '../features/client/client_home/screens/client_home_screen.dart';

import '../features/pro/pro_landing/screens/pro_landing_screen.dart';
import '../features/pro/pro_establishment_type/screens/pro_establishment_type_screen.dart';
import '../features/pro/pro_establishment_details/screens/pro_establishment_details_screen.dart';
import '../features/pro/pro_salon_info/screens/pro_salon_info_screen.dart';
import '../features/pro/pro_account_details/screens/pro_account_details_screen.dart';
import '../features/pro/pro_home/screens/pro_home_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';

  static const String clientHome = '/client-home';

  static const String proLanding = '/pro';
  static const String proEstablishmentType = '/pro/establishment-type';
  static const String proEstablishmentDetails = '/pro/establishment-details';
  static const String proAccountDetails = '/pro/account-details';
  static const String proSalonInfo = '/pro/salon-info';
  static const String proHome = '/pro/home';

  static Map<String, WidgetBuilder> get routes => {
    home: (context) => const HomeScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),

    clientHome: (context) => const AuthGuard(child: ClientHomeScreen()),
    proLanding: (context) => const ProLandingScreen(),
    proEstablishmentType: (context) => const ProEstablishmentTypeScreen(),
    proAccountDetails: (context) => const ProAccountDetailsScreen(),
    proEstablishmentDetails: (context) => const ProEstablishmentDetailsScreen(),
    proSalonInfo: (context) => const ProSalonInfoScreen(),
    proHome: (context) => const ProHomeScreen(),
  };
}
