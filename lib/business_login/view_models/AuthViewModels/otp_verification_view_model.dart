import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/models/pass_call_outcome.dart';
import 'package:fridayy_one/business_login/utils/api_constants.dart';
import 'package:fridayy_one/business_login/utils/routing_constants.dart';
import 'package:fridayy_one/business_login/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationViewModel extends BaseModel {
  final formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  StreamController<ErrorAnimationType> otpErrorController =
      StreamController<ErrorAnimationType>();
  late String otpId;
  late String mobile;

  init(String receivedOtpId, String receivedMobile) {
    otpId = receivedOtpId;
    mobile = receivedMobile;
  }

  verifyLogin() async {
    if (formKey.currentState!.validate() &&
        otpController.text.isNotEmpty &&
        otpController.text.length == 4) {
      final CallOutcome<Map<String, dynamic>> result =
          await apiService.postRequest(
        ApiConstants.loginOtpValidate,
        {
          'otpId': otpId,
          'otp': otpController.text,
          'mobile': mobile,
        },
        isAuth: true,
      );
      if (result.data != null) {
        localDatabaseService.saveUserAuth(
          result.data!['auth'].toString(),
        ); //'cbfed2c4-d6a4-4d32-9994-f63f2f7e2f67');//userXInternalKey['auth']
        if (result.exception == null) {
          final Map<String, String> fields = {};
          fields['key'] =
              result.data!['s3_details']['fields']['key'].toString();
          fields['x-amz-algorithm'] = result.data!['s3_details']['fields']
                  ['x-amz-algorithm']
              .toString();
          fields['x-amz-credential'] = result.data!['s3_details']['fields']
                  ['x-amz-credential']
              .toString();
          fields['x-amz-date'] =
              result.data!['s3_details']['fields']['x-amz-date'].toString();
          fields['policy'] =
              result.data!['s3_details']['fields']['policy'].toString();
          fields['x-amz-signature'] = result.data!['s3_details']['fields']
                  ['x-amz-signature']
              .toString();
          messageService.s3BucketFields = fields;
          messageService.bucketUrl =
              result.data!['s3_details']['url'] as String;
          navigationService.removeAllAndPush(
            Routes.homeScreen,
            Routes.splashScreen,
            arguments: {'autoLogin': false},
          );
        } else {
          navigationService.showSnackBar('No messages to send');
        }
      }
    } else {
      navigationService.showSnackBar('Enter the otp to continue');
    }
  }

  verifyRegister() async {
    if (formKey.currentState!.validate() &&
        otpController.text.isNotEmpty &&
        otpController.text.length == 4) {
      final CallOutcome<Map<String, dynamic>> result =
          await apiService.postRequest(
        ApiConstants.registerOtpValidate,
        {
          'otpId': otpId,
          'otp': otpController.text,
          'mobile': mobile,
        },
        isAuth: true,
      );
      if (result.data != null) {
        localDatabaseService.saveUserAuth(result.data!['auth'].toString());
        if (result.exception == null) {
          messageService.s3BucketFields =
              result.data!['s3_details']['fields'] as Map<String, String>;
          messageService.bucketUrl =
              result.data!['s3_details']['url'] as String;
          navigationService.removeAllAndPush(
            Routes.homeScreen,
            Routes.splashScreen,
            arguments: {'autoLogin': false},
          );
        } else {
          navigationService.showSnackBar('No messages to send');
        }
      }
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
