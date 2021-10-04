import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/models/user_model.dart';
import 'package:fridayy_one/business_login/utils/api_constants.dart';
import 'package:fridayy_one/business_login/utils/routing_constants.dart';
import 'package:fridayy_one/business_login/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:permission_handler/permission_handler.dart';

class SignupScreenViewModel extends BaseModel {
  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController name = TextEditingController();

  verify() async {
    if (formKey.currentState!.validate()) {
      final status = await Permission.sms.request();
      if (status.isGranted) {
        final UserModel user = UserModel(
          mobile: phoneNumber.text,
          countryCode: "+91",
          userName: name.text,
        );
        final otpId = await apiService
            .postRequest(ApiConstants.register, user.toJson(), isAuth: true);
        if (otpId != null) {
          print(otpId);
          navigationService.pushScreen(
            Routes.otpInputScreen,
            arguments: {
              'signupDetails': phoneNumber.text,
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

  void gotoLogin() {
    navigationService.pushReplacementScreen(Routes.loginScreen);
  }

  void signupWithGoogle() {
    navigationService.showSnackBar('In progress');
  }
}
