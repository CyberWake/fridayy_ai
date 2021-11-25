import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/view_models/AuthViewModels/otp_verification_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/base_view.dart';
import 'package:fridayy_one/ui/widgets/continue_with_google.dart';
import 'package:fridayy_one/ui/widgets/custom_text_field_with_title/custom_textfield.dart';
import 'package:fridayy_one/ui/widgets/rounded_rectangular_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({
    Key? key,
    required this.isFromLogin,
    required this.phoneNumber,
    required this.otpId,
  }) : super(key: key);
  final bool isFromLogin;
  final String otpId;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return BaseView<OtpVerificationViewModel>(
      onModelReady: (model) => model.init(otpId, phoneNumber),
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            model.otpErrorController.close();
            return true;
          },
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(sizeConfig.getPropWidth(35)),
                child: Form(
                  key: model.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: sizeConfig.getPropHeight(108),
                      ),
                      Text(
                        "Enter OTP",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: sizeConfig.getPropHeight(30),
                      ),
                      CustomTextFieldWithTitle(
                        title: "Mobile Number",
                        initialText: phoneNumber,
                        validator: (number) {},
                        prefix: "+91 ",
                        enabled: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: sizeConfig.getPropHeight(18),
                      ),
                      SizedBox(
                        width: sizeConfig.getPropWidth(250),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enter OTP',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 16),
                            ),
                            PinCodeTextField(
                              length: 4,
                              obscureText: false,
                              animationType: AnimationType.fade,
                              hapticFeedbackTypes: HapticFeedbackTypes.medium,
                              keyboardType: TextInputType.number,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(10),
                                fieldHeight: 50,
                                fieldWidth: 50,
                                selectedColor: const Color(0xFF2128BD),
                                activeColor: const Color(0xFF2128BD),
                                inactiveColor: const Color(0xFF2128BD),
                                borderWidth: 1.0,
                                activeFillColor: Colors.white,
                                selectedFillColor: Colors.white,
                                inactiveFillColor: Colors.white,
                              ),
                              animationDuration:
                                  const Duration(milliseconds: 300),
                              backgroundColor: Colors.transparent,
                              boxShadows: [
                                BoxShadow(
                                  spreadRadius: 0,
                                  blurRadius: 20,
                                  offset: const Offset(4, 10),
                                  color:
                                      const Color(0xFF000000).withOpacity(0.1),
                                ),
                              ],
                              enableActiveFill: true,
                              errorAnimationController:
                                  model.otpErrorController,
                              controller: model.otpController,
                              onCompleted: (v) {
                                print("Completed");
                              },
                              onChanged: (value) {},
                              beforeTextPaste: (text) {
                                print("Allowing to paste $text");
                                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                return true;
                              },
                              appContext: context,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: sizeConfig.getPropHeight(50),
                      ),
                      Center(
                        child: CustomRoundRectButton(
                          onTap: isFromLogin
                              ? model.verifyLogin
                              : model.verifyRegister,
                          child: Text(
                            isFromLogin ? 'Sign In' : 'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      ContinueWith(
                        isLogin: isFromLogin,
                        onTap: isFromLogin ? model.gotoSignup : model.gotoLogin,
                        onGoogleTap: isFromLogin
                            ? model.loginWithGoogle
                            : model.signupWithGoogle,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
