import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/utils/custom_painters/google_logo.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/draw.dart';

class ContinueWith extends StatelessWidget {
  const ContinueWith({
    Key? key,
    required this.isLogin,
    required this.onTap,
    required this.onGoogleTap,
  }) : super(key: key);
  final bool isLogin;
  final void Function() onTap;
  final void Function() onGoogleTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: sizeConfig.getPropHeight(30),
        ),
        Text(
          'or',
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: const Color(0xFF666666).withOpacity(1)),
        ),
        SizedBox(
          height: sizeConfig.getPropHeight(20),
        ),
        Material(
          elevation: 3.0,
          shadowColor: const Color(0xFF000000).withOpacity(0.16),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onGoogleTap,
            child: Container(
              alignment: Alignment.center,
              height: sizeConfig.getPropHeight(34),
              width: sizeConfig.getPropWidth(240),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Draw(
                    painter: GoogleLogo(),
                    squareSize: 30,
                  ),
                  Text(
                    isLogin ? 'Sign in with Google' : 'Sign up with Google',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: sizeConfig.getPropHeight(56),
        ),
        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isLogin ? 'Don’t have an account? ' : 'Already a member? ',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: const Color(0xFF666666).withOpacity(1)),
              ),
              TextButton(
                onPressed: onTap,
                child: Text(
                  isLogin ? 'Signup' : 'Login',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
