import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/user_overview_model.dart';
import 'package:fridayy_one/business_logic/utils/routing_constants.dart';
import 'package:fridayy_one/main.dart';
import 'package:fridayy_one/ui/views/AuthPages/auth_view.dart';
import 'package:fridayy_one/ui/views/AuthPages/login_view.dart';
import 'package:fridayy_one/ui/views/AuthPages/otp_verification_view.dart';
import 'package:fridayy_one/ui/views/AuthPages/signup_view.dart';
import 'package:fridayy_one/ui/views/HomePages/home_screen_holder_view.dart';
import 'package:fridayy_one/ui/views/brand_offers_screen_view.dart';
import 'package:fridayy_one/ui/views/onboarding_view.dart';
import 'package:fridayy_one/ui/views/splash_screen_view.dart';
import 'package:fridayy_one/ui/views/story_screen_view.dart';

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
        transitionDuration: const Duration(milliseconds: 750),
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
      if (inputData.containsKey('signupDetails') &&
          inputData.containsKey('otpId')) {
        return CupertinoPageRoute(
          builder: (context) => OtpVerification(
            key: const Key('SignupOtpVerification'),
            isFromLogin: false,
            phoneNumber: inputData['signupDetails'] as String,
            otpId: inputData['otpId'] as String,
          ),
        );
      } else if (inputData.containsKey('loginDetails') &&
          inputData.containsKey('otpId')) {
        return CupertinoPageRoute(
          builder: (context) => OtpVerification(
            key: const Key('LoginOtpVerification'),
            isFromLogin: true,
            phoneNumber: inputData['loginDetails'] as String,
            otpId: inputData['otpId'] as String,
          ),
        );
      } else {
        final String page = settings.arguments! as String;
        return MaterialPageRoute(
          builder: (context) => MyHomePage(
            key: const Key('ToBeMade'),
            title: page,
          ),
        );
      }
    case Routes.homeScreen:
      final Map<String, dynamic> inputData =
          settings.arguments! as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) => HomeScreenHolder(
          key: const Key('HomeScreenView'),
          autoLogin: inputData['autoLogin'] as bool,
        ),
      );
    case Routes.brandOffers:
      final Map<String, dynamic> inputData =
          settings.arguments! as Map<String, dynamic>;
      return CupertinoPageRoute(
        builder: (context) => BrandOffersView(
          key: const Key('BrandOffersView'),
          offers: inputData["offers"] as List<NotifiedOffers>,
          brandData: inputData["brandData"] as List,
        ),
      );
    case Routes.storyScreen:
      final Map<String, dynamic> inputData =
          settings.arguments! as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) => StoryScreenView(
          key: const Key('StoryScreen'),
          offers: inputData["offers"] as List<NotifiedOffers>,
          startIndex: inputData["startIndex"] as int,
        ),
      );
    case Routes.toBeMade:
      final String page = settings.arguments! as String;
      return MaterialPageRoute(
        builder: (context) => MyHomePage(
          key: const Key('ToBeMade'),
          title: page,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const MyHomePage(
          key: Key('Error'),
          title: 'Error',
        ),
      );
  }
}
