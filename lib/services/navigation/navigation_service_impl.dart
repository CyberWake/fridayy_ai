import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fridayy_one/services/navigation/navigation_service.dart';

class NavigationServiceImpl extends NavigationService {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<dynamic> pushScreen(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  @override
  Future<dynamic> popAndPushScreen(String routeName, {dynamic arguments}) {
    navigatorKey.currentState!.pop();
    return pushScreen(routeName, arguments: arguments);
  }

  @override
  Future<dynamic> pushReplacementScreen(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  @override
  Future<dynamic> popAndPushReplacement(String routeName, {dynamic arguments}) {
    navigatorKey.currentState!.pop();
    return pushReplacementScreen(routeName, arguments: arguments);
  }

  @override
  Future<dynamic> removeAllAndPush(
    String routeName,
    String tillRoute, {
    dynamic arguments,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      ModalRoute.withName(tillRoute),
      arguments: arguments,
    );
  }

  @override
  void pushDialog(Widget dialog) {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  @override
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) =>
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: duration,
          content: Text(message),
        ),
      );

  @override
  void pop() {
    return navigatorKey.currentState!.pop();
  }
}
