import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/pass_call_outcome.dart';
import 'package:fridayy_one/business_logic/models/user_model.dart';
import 'package:fridayy_one/business_logic/utils/api_constants.dart';
import 'package:fridayy_one/business_logic/utils/enums.dart';
import 'package:fridayy_one/business_logic/utils/extensions.dart';
import 'package:fridayy_one/business_logic/utils/routing_constants.dart';
import 'package:fridayy_one/business_logic/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:permission_handler/permission_handler.dart';

class SignupScreenViewModel extends BaseModel {
  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController name = TextEditingController();
  Gender? userGender;
  bool terms = false;
  bool privacy = false;

  verify() async {
    if (formKey.currentState!.validate() &&
        terms &&
        privacy &&
        userGender != null) {
      final status = await Permission.sms.request();
      if (status.isGranted) {
        final UserModel user = UserModel(
          mobile: phoneNumber.text,
          countryCode: "+91",
          userName: name.text,
          gender: userGender!.string().toUpperCase(),
        );
        final CallOutcome<Map<String, dynamic>> result = await apiService
            .postRequest(ApiConstants.register, user.toJson(), isAuth: true);
        if (result.data != null) {
          navigationService.pushScreen(
            Routes.otpInputScreen,
            arguments: {
              'signupDetails': phoneNumber.text,
              'otpId': result.data!['otp_id']
            },
          );
        } else if (result.exception.toString() ==
            "Exception: Mobile No. Already Exists") {
          Future.delayed(const Duration(seconds: 1))
              .then((value) => gotoLogin());
        }
      } else if (status.isPermanentlyDenied) {
        navigationService.showSnackBar('Enable the permissions from settings');
      } else {
        navigationService.showSnackBar(
          'Please provide the permission to enjoy our services',
        );
      }
    } else if (userGender == null) {
      navigationService.showSnackBar('Select gender to continue');
    } else if (!terms && !privacy) {
      navigationService
          .showSnackBar('Accept terms & conditions, privacy policy');
    } else if (!terms) {
      navigationService.showSnackBar('Accept terms & conditions to continue');
    } else if (!privacy) {
      navigationService.showSnackBar('Accept privacy policy to continue');
    }
  }

  void switchGender(Gender newGender) {
    userGender = newGender;
    setState(ViewState.idle);
  }

  void gotoLogin() {
    navigationService.pushReplacementScreen(Routes.loginScreen);
  }

  void signupWithGoogle() {
    navigationService.showSnackBar('In progress');
  }

  void updateTerms(bool? value) {
    terms = value ?? false;
    setState(ViewState.idle);
  }

  void updatePrivacy(bool? value) {
    privacy = value ?? false;
    setState(ViewState.idle);
  }

  void showTerms() {
    navigationService.showSnackBar('opens terms and conditions in browser');
  }

  void showPrivacy() {
    navigationService.showSnackBar('opens privacy policy in browser');
  }
}
