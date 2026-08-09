import 'package:firebase_setup/feature/home/presentation/home_page.dart';
import 'package:firebase_setup/feature/login/presentation/forgot_password_page.dart';
import 'package:firebase_setup/feature/login/presentation/login_page.dart';
import 'package:firebase_setup/feature/onboarding/discover_page.dart';
import 'package:firebase_setup/feature/onboarding/onboarding_page.dart';
import 'package:firebase_setup/feature/onboarding/onboarding_screen.dart';
import 'package:firebase_setup/feature/product/presentation/add_product_page.dart';
import 'package:firebase_setup/feature/signup/presentation/sign_up_page.dart';
import 'package:firebase_setup/route/route.dart';
import 'package:firebase_setup/shared_widget/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static navigateToPage(
    BuildContext context,
    String route, {
    dynamic arguments,
  }) {
    Navigator.push(
      context,
      generateRoute(RouteSettings(name: route, arguments: arguments)),
    );
  }

  static navigateToPageWithoutStack(
    BuildContext context,
    String route, {
    dynamic arguments,
  }) {
    Navigator.pushAndRemoveUntil(
      context,
      generateRoute(RouteSettings(name: route, arguments: arguments)),
      (route) => false,
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboardingPageRoute:
        return MaterialPageRoute(builder: (_) => OnboardingPage());
      case Routes.onboardingScreenRoute:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => ForgotPasswordPage());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case Routes.bottomNavBarRoute:
        return MaterialPageRoute(builder: (_) => BottomNavbar());
        case Routes.addProductRoute:
        return MaterialPageRoute(builder: (_) => AddProductPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
