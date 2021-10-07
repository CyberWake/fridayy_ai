import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/models/user_model.dart';
import 'package:fridayy_one/business_login/utils/api_constants.dart';
import 'package:fridayy_one/business_login/utils/routing_constants.dart';
import 'package:fridayy_one/business_login/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginScreenViewModel extends BaseModel {
  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumber = TextEditingController();

  verify() async {
    if (formKey.currentState!.validate()) {
      final status = await Permission.sms.request();
      if (status.isGranted) {
        final UserModel user =
            UserModel(mobile: phoneNumber.text, countryCode: "+91");
        final otpId = await apiService
            .postRequest(ApiConstants.login, user.toJson(), isAuth: true);
        print(otpId);
        if (otpId != null) {
          navigationService.pushScreen(
            Routes.otpInputScreen,
            arguments: {
              'loginDetails': phoneNumber.text,
              'otpId': otpId['otpId']
            },
          );
        }
      } else if (status.isPermanentlyDenied) {
        navigationService.showSnackBar('Enable the permissions from settings');
      } else {
        navigationService.showSnackBar(
          'Please provide the permission to enjoy our services',
        );
      }
    }
  }

  void gotoSignup() {
    navigationService.pushReplacementScreen(Routes.signupScreen);
  }

  void loginWithGoogle() {
    navigationService.showSnackBar('In progress');
  }
}
