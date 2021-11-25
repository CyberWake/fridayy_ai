import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/utils/validators.dart';
import 'package:fridayy_one/business_logic/view_models/AuthViewModels/signup_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/base_view.dart';
import 'package:fridayy_one/ui/widgets/continue_with_google.dart';
import 'package:fridayy_one/ui/widgets/custom_gender_selector/custom_gender_selector.dart';
import 'package:fridayy_one/ui/widgets/custom_text_field_with_title/custom_textfield.dart';
import 'package:fridayy_one/ui/widgets/rounded_rectangular_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  Widget _buildCheckBoxWithText(
    BuildContext context,
    String title,
    String subTitle,
    bool value,
    Function(bool?) update,
    Function()? onTap,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          checkColor: Colors.white,
          activeColor: const Color(0xFF2128BD),
          value: value,
          tristate: true,
          onChanged: (state) {
            FocusScope.of(context).requestFocus();
            update(state);
          },
        ),
        SizedBox(
          height: sizeConfig.getPropWidth(8),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: title,
              style: Theme.of(navigationService.navigatorKey.currentContext!)
                  .textTheme
                  .caption!
                  .copyWith(
                    fontSize: 16,
                    color: const Color(0xFF666666),
                  ),
              children: [
                TextSpan(
                  text: subTitle,
                  style:
                      Theme.of(navigationService.navigatorKey.currentContext!)
                          .textTheme
                          .caption!
                          .copyWith(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                  recognizer: TapGestureRecognizer()..onTap = onTap,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SignupScreenViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: model.formKey,
              child: Padding(
                padding: EdgeInsets.all(sizeConfig.getPropWidth(35)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: sizeConfig.getPropHeight(25),
                    ),
                    Text(
                      "Create an account",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(
                      height: sizeConfig.getPropHeight(30),
                    ),
                    CustomTextFieldWithTitle(
                      title: "Mobile Number",
                      controller: model.phoneNumber,
                      validator: (number) =>
                          Validate.validatePhoneNumber(number),
                      prefix: "+91 ",
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(
                      height: sizeConfig.getPropHeight(10),
                    ),
                    CustomTextFieldWithTitle(
                      title: "Name",
                      hintText: "Name",
                      controller: model.name,
                      validator: (number) => Validate.validateName(number),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(
                      height: sizeConfig.getPropHeight(10),
                    ),
                    CustomGenderSelector(
                      selected: model.userGender,
                      updateGender: model.switchGender,
                    ),
                    SizedBox(
                      height: sizeConfig.getPropHeight(10),
                    ),
                    _buildCheckBoxWithText(
                      context,
                      'I agree with ',
                      'Terms and Conditions',
                      model.terms,
                      model.updateTerms,
                      model.showTerms,
                    ),
                    _buildCheckBoxWithText(
                      context,
                      'I agree with Fridayy Ai ',
                      'Privacy Policy',
                      model.privacy,
                      model.updatePrivacy,
                      model.showPrivacy,
                    ),
                    SizedBox(
                      height: sizeConfig.getPropHeight(20),
                    ),
                    Center(
                      child: CustomRoundRectButton(
                        onTap: model.verify,
                        child: Text(
                          'Sign Up',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    ContinueWith(
                      isLogin: false,
                      onTap: model.gotoLogin,
                      onGoogleTap: model.signupWithGoogle,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
