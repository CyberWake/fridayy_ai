import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:fridayy_one/business_login/utils/routing_constants.dart';
import 'package:fridayy_one/business_login/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationViewModel extends BaseModel {
  final formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  StreamController<ErrorAnimationType> otpErrorController =
      StreamController<ErrorAnimationType>();

  void verify() {
    if (formKey.currentState!.validate() &&
        otpController.text.isNotEmpty &&
        otpController.text.length == 4) {
      navigationService.removeAllAndPush(
        Routes.homeScreen,
        Routes.splashScreen,
      );
    } else {
      navigationService.showSnackBar('Enter the otp to continue');
    }
  }

  void gotoLogin() {
    navigationService.popAndPushReplacement(Routes.loginScreen);
  }

  void gotoSignup() {
    navigationService.popAndPushReplacement(Routes.signupScreen);
  }

  void signupWithGoogle() {
    navigationService.showSnackBar('In progress');
  }

  void loginWithGoogle() {
    navigationService.showSnackBar('In progress');
  }
}
