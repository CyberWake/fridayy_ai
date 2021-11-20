import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/pass_call_outcome.dart';
import 'package:fridayy_one/business_logic/models/user_model.dart';
import 'package:fridayy_one/business_logic/utils/api_constants.dart';
import 'package:fridayy_one/business_logic/utils/routing_constants.dart';
import 'package:fridayy_one/business_logic/view_models/base_view_model.dart';
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
        final CallOutcome<Map<String, dynamic>> result = await apiService
            .postRequest(ApiConstants.login, user.toJson(), isAuth: true);
        print(result.exception);
        if (result.data != null) {
          navigationService.pushScreen(
            Routes.otpInputScreen,
            arguments: {
              'loginDetails': phoneNumber.text,
              'otpId': result.data!['otpId']
            },
          );
        } else if (result.exception.toString() ==
            "Exception: Mobile No. Not Found") {
          Future.delayed(const Duration(seconds: 1))
              .then((value) => gotoSignup());
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
