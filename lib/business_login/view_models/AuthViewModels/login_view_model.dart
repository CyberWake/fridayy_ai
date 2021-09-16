import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/utils/routing_constants.dart';
import 'package:fridayy_one/business_login/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class LoginScreenViewModel extends BaseModel {
  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumber = TextEditingController();

  void verify() {
    if (formKey.currentState!.validate()) {
      navigationService.pushScreen(
        Routes.otpInputScreen,
        arguments: {'loginDetails': phoneNumber.text},
      );
    }
  }

  void gotoSignup() {
    navigationService.pushReplacementScreen(Routes.signupScreen);
  }

  void loginWithGoogle() {
    navigationService.showSnackBar('In progress');
  }
}
