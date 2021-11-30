import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/spends_model.dart';
import 'package:fridayy_one/business_logic/models/user_overview_model.dart';
import 'package:fridayy_one/business_logic/utils/routing_constants.dart';
import 'package:fridayy_one/main.dart';
import 'package:fridayy_one/ui/views/AuthPages/auth_view.dart';
import 'package:fridayy_one/ui/views/AuthPages/login_view.dart';
import 'package:fridayy_one/ui/views/AuthPages/otp_verification_view.dart';
import 'package:fridayy_one/ui/views/AuthPages/signup_view.dart';
import 'package:fridayy_one/ui/views/HomePages/Offer/brand_offers_screen_view.dart';
import 'package:fridayy_one/ui/views/HomePages/dashboard/story_screen_view.dart';
import 'package:fridayy_one/ui/views/HomePages/home_screen_holder_view.dart';
import 'package:fridayy_one/ui/views/HomePages/spend/brand_transactions.dart';
import 'package:fridayy_one/ui/views/HomePages/spend/edit_spend_view.dart';
import 'package:fridayy_one/ui/views/HomePages/spend/spend_view.dart';
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
          activePage: inputData['activePage'] == null
              ? 0
              : inputData['activePage'] as int,
        ),
      );
    case Routes.brandOffers:
      final Map<String, dynamic> inputData =
          settings.arguments! as Map<String, dynamic>;
      return CupertinoPageRoute(
        builder: (context) => BrandOffersView(
          key: const Key('BrandOffersView'),
          brandName: inputData["brandName"] as String,
          brandId: inputData["brandId"] as String,
        ),
      );
    case Routes.brandTransactionsScreen:
      final Map<String, dynamic> inputData =
          settings.arguments! as Map<String, dynamic>;
      return CupertinoPageRoute(
        builder: (context) => BrandTransactions(
          key: const Key('BrandTransactions'),
          brandName: inputData["brandName"] as String,
          brandId: inputData["brandId"] as String,
          amountSpend: inputData["amountSpend"] as double,
          month: inputData["month"] as String,
          filter: inputData["filter"] as String,
        ),
      );
    case Routes.storyScreen:
      final Map<String, dynamic> inputData =
          settings.arguments! as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) => StoryScreenView(
          key: const Key('StoryScreenView'),
          offers: inputData["offers"] as List<OffersByBrand>,
          startIndex: inputData["startIndex"] as int,
        ),
      );
    case Routes.spendScreen:
      final Map<String, dynamic> inputData =
          settings.arguments! as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) => SpendView(
          key: const Key('SpendView'),
          spendId: inputData['spendId'] as String,
        ),
      );
    case Routes.editSpendScreen:
      final Map<String, dynamic> inputData =
          settings.arguments! as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) => EditSpendView(
          key: const Key('EditSpendView'),
          spendInfo: inputData['spendInfo'] as SpendsModel,
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
