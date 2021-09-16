import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/utils/custom_painters/fridayy_logo/logo.dart';
import 'package:fridayy_one/business_login/view_models/AuthViewModels/auth_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/base_view.dart';
import 'package:fridayy_one/ui/widgets/rounded_rectangular_button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthScreenViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: sizeConfig.getPropHeight(290),
                ),
                CustomPaint(
                  size: Size(
                    sizeConfig.getPropWidth(97),
                    sizeConfig.getPropHeight(
                      97,
                    ),
                  ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                  painter: FridayyLogo(),
                ),
                SizedBox(
                  height: sizeConfig.getPropHeight(7),
                ),
                Text(
                  'Fridayy',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: sizeConfig.getPropHeight(163),
                ),
                CustomRoundRectButton(
                  onTap: model.gotoLogin,
                  child: Text(
                    'Sign In',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: sizeConfig.getPropHeight(16),
                ),
                CustomRoundRectButton(
                  onTap: model.gotoSignup,
                  fillColor: Colors.white,
                  child: Text(
                    'Sign Up',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
