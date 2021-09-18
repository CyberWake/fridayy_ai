import 'package:flutter/material.dart';

abstract class NavigationService {
  Future<dynamic> pushScreen(String routeName, {dynamic arguments});
  Future<dynamic> popAndPushScreen(String routeName, {dynamic arguments});
  Future<dynamic> pushReplacementScreen(String routeName, {dynamic arguments});
  Future<dynamic> popAndPushReplacement(String routeName, {dynamic arguments});
  Future<dynamic> removeAllAndPush(
    String routeName,
    String tillRoute, {
    dynamic arguments,
  });
  void pushDialog(Widget dialog);
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 2),
  });
  void pop();
}
