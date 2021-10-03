import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/view_models/AuthViewModels/otp_verification_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/base_view.dart';
import 'package:fridayy_one/ui/widgets/continue_with_google.dart';
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
                padding: EdgeInsets.only(left: sizeConfig.getPropWidth(15)),
                child: Form(
                  key: model.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: sizeConfig.getPropHeight(142),
                      ),
                      Text(
                        isFromLogin ? "Sign In" : "Sign Up",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          sizeConfig.getPropHeight(34),
                          sizeConfig.getPropHeight(28),
                          sizeConfig.getPropHeight(190),
                          0,
                        ),
                        child: TextFormField(
                          enabled: false,
                          keyboardType: TextInputType.phone,
                          initialValue: phoneNumber,
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: sizeConfig.getPropWidth(2),
                          ),
                          decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF2128BD)),
                            ),
                            errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFB00020)),
                            ),
                            disabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF2128BD)),
                            ),
                            prefixText: '+91 ',
                            hintText: 'Mobile Number',
                            label: Text(
                              'Mobile Number',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          sizeConfig.getPropHeight(34),
                          sizeConfig.getPropHeight(28),
                          sizeConfig.getPropHeight(190),
                          0,
                        ),
                        child: SizedBox(
                          width: sizeConfig.getPropWidth(92),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Enter OTP',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              PinCodeTextField(
                                length: 4,
                                obscureText: false,
                                animationType: AnimationType.fade,
                                hapticFeedbackTypes: HapticFeedbackTypes.medium,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.underline,
                                  borderRadius: BorderRadius.circular(5),
                                  fieldHeight: 50,
                                  fieldWidth: sizeConfig.getPropWidth(17),
                                  activeFillColor: Colors.white,
                                  selectedFillColor: Colors.white,
                                  inactiveFillColor: Colors.white,
                                ),
                                animationDuration:
                                    const Duration(milliseconds: 300),
                                backgroundColor: Colors.transparent,
                                enableActiveFill: true,
                                errorAnimationController:
                                    model.otpErrorController,
                                controller: model.otpController,
                                onCompleted: (v) {
                                  print("Completed");
                                },
                                onChanged: (value) {
                                  print(value);
                                },
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
                      ),
                      SizedBox(
                        height: sizeConfig.getPropHeight(65),
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
