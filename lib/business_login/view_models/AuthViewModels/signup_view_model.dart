import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/models/signup_detail.dart';
import 'package:fridayy_one/business_login/utils/routing_constants.dart';
import 'package:fridayy_one/business_login/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class SignupScreenViewModel extends BaseModel {
  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController name = TextEditingController();

  void verify() {
    if (formKey.currentState!.validate()) {
      navigationService.pushScreen(
        Routes.otpInputScreen,
        arguments: {
          'signupDetails':
              SignupDetails(name: name.text, phoneNumber: phoneNumber.text)
        },
      );
    }
  }

  void gotoLogin() {
    navigationService.pushReplacementScreen(Routes.loginScreen);
  }

  void signupWithGoogle() {
    navigationService.showSnackBar('In progress');
  }
}
