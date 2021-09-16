import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/models/signup_detail.dart';
import 'package:fridayy_one/business_login/utils/routing_constants.dart';
import 'package:fridayy_one/main.dart';
import 'package:fridayy_one/ui/views/AuthPages/auth_view.dart';
import 'package:fridayy_one/ui/views/AuthPages/login_view.dart';
import 'package:fridayy_one/ui/views/AuthPages/otp_verification_view.dart';
import 'package:fridayy_one/ui/views/AuthPages/signup_view.dart';
import 'package:fridayy_one/ui/views/onboarding_view.dart';
import 'package:fridayy_one/ui/views/splash_screen_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.splashScreen:
      return MaterialPageRoute(
        builder: (context) => const SplashScreen(key: Key('SplashScreen')),
      );
    case Routes.onBoardingScreen:
      return PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) =>
            const OnBoardingScreen(key: Key('OnBoarding')),
        transitionDuration: const Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(curve: Curves.easeOut, parent: animation);
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
      );
    case Routes.authScreen:
      return CupertinoPageRoute(
        builder: (context) => const AuthScreen(key: Key('AuthHolder')),
      );
    case Routes.loginScreen:
      return CupertinoPageRoute(
        builder: (context) => const LoginScreen(key: Key('LoginScreen')),
      );
    case Routes.signupScreen:
      return CupertinoPageRoute(
        builder: (context) => const SignupScreen(key: Key('SignupScreen')),
      );
    case Routes.otpInputScreen:
      final Map<String, dynamic> inputData =
          settings.arguments! as Map<String, dynamic>;
      if (inputData.containsKey('signupDetails')) {
        return CupertinoPageRoute(
          builder: (context) => OtpVerification(
            key: const Key('SignupOtpVerification'),
            isFromLogin: false,
            signupInfo: inputData['signupDetails'] as SignupDetails,
          ),
        );
      } else {
        return CupertinoPageRoute(
          builder: (context) => OtpVerification(
            key: const Key('LoginOtpVerification'),
            isFromLogin: true,
            phoneNumber: inputData['loginDetails'] as String,
          ),
        );
      }
    default:
      return MaterialPageRoute(
        builder: (context) => const MyHomePage(
          key: Key('Error'),
          title: 'Error',
        ),
      );
  }
}
