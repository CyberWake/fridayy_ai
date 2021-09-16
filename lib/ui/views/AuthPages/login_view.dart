import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/utils/validators.dart';
import 'package:fridayy_one/business_login/view_models/AuthViewModels/login_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/base_view.dart';
import 'package:fridayy_one/ui/widgets/continue_with_google.dart';
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
                padding: EdgeInsets.all(sizeConfig.getPropWidth(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: sizeConfig.getPropHeight(142),
                    ),
                    Text(
                      "Sign In",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        sizeConfig.getPropHeight(34),
                        sizeConfig.getPropHeight(128),
                        sizeConfig.getPropHeight(190),
                        0,
                      ),
                      child: TextFormField(
                        controller: model.phoneNumber,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: sizeConfig.getPropWidth(2),
                        ),
                        validator: (number) =>
                            Validate.validatePhoneNumber(number),
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF2128BD)),
                          ),
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFB00020)),
                          ),
                          prefixText: '+91 ',
                          hintText: 'Mobile Number',
                          errorStyle:
                              Theme.of(context).textTheme.caption!.copyWith(
                                    fontSize: 12,
                                    color: const Color(0xFFB00020),
                                  ),
                          label: Text(
                            'Mobile Number',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ),
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
