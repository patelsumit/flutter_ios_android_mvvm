import 'package:flutter/material.dart';
import 'package:flutter_ios_android_mvvm/utils/routes/routes_name.dart';
import 'package:flutter_ios_android_mvvm/view/home_screen.dart';
import 'package:flutter_ios_android_mvvm/view/login_view.dart';
import 'package:flutter_ios_android_mvvm/view/sign_up_view.dart';
import 'package:flutter_ios_android_mvvm/view/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());
      case RoutesName.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpView());
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashView());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No Route defined...'),
            ),
          );
        });
    }
  }
}
