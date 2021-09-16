import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/onboarding_screen_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/OnBoardingPages/onboarding_page_one.dart';
import 'package:fridayy_one/ui/views/OnBoardingPages/onboarding_page_two.dart';
import 'package:fridayy_one/ui/views/OnBoardingPages/onboarding_page_zero.dart';
import 'package:fridayy_one/ui/views/base_view.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<OnBoardingScreenViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              PageView.builder(
                controller: model.controller,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  switch (index) {
                    case 0:
                      return const OnBoardingPageZero();
                    case 1:
                      return const OnBoardingPageOne();
                    default:
                      return const OnBoardingPageTwo();
                  }
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: sizeConfig.getPropHeight(58),
                  ),
                  child: SizedBox(
                    width: sizeConfig.getPropWidth(58),
                    height: sizeConfig.getPropHeight(58),
                    child: FloatingActionButton(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      backgroundColor: const Color(0xff2128bd).withOpacity(1.0),
                      onPressed: () {
                        if (model.controller.page! <= 1.0) {
                          model.controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.decelerate,);
                        } else {
                          navigationService.pushReplacementScreen('/auth');
                        }
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
