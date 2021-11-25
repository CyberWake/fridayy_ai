import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/utils/validators.dart';
import 'package:fridayy_one/business_logic/view_models/AuthViewModels/login_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/base_view.dart';
import 'package:fridayy_one/ui/widgets/continue_with_google.dart';
import 'package:fridayy_one/ui/widgets/custom_text_field_with_title/custom_textfield.dart';
import 'package:fridayy_one/ui/widgets/rounded_rectangular_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginScreenViewModel>(
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
                      height: sizeConfig.getPropHeight(108),
                    ),
                    Text(
                      "Welcome back!",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(
                      height: sizeConfig.getPropHeight(127),
                    ),
                    CustomTextFieldWithTitle(
                      title: "Mobile Number",
                      controller: model.phoneNumber,
                      validator: (number) =>
                          Validate.validatePhoneNumber(number),
                      prefix: "+91 ",
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(
                      height: sizeConfig.getPropHeight(48),
                    ),
                    Center(
                      child: CustomRoundRectButton(
                        onTap: model.verify,
                        child: Text(
                          'Sign In',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    ContinueWith(
                      isLogin: true,
                      onTap: model.gotoSignup,
                      onGoogleTap: model.loginWithGoogle,
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
