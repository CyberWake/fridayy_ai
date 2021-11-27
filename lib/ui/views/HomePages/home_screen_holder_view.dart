import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/home_screen_holder_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/HomePages/Offer/offer_screen_view.dart';
import 'package:fridayy_one/ui/views/HomePages/dashboard/home_screen_view.dart';
import 'package:fridayy_one/ui/views/HomePages/profile_screen_view.dart';
import 'package:fridayy_one/ui/views/HomePages/spend/spending_screen_view.dart';
import 'package:fridayy_one/ui/views/base_view.dart';

class HomeScreenHolder extends StatelessWidget {
  const HomeScreenHolder({Key? key, this.autoLogin = true}) : super(key: key);
  final bool autoLogin;

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeScreenHolderViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: PageView(
            controller: model.controller,
            onPageChanged: model.newPage,
            children: [
              HomeScreen(homeModel: model, isAutoLogin: autoLogin),
              OfferScreen(
                homeModel: model,
              ),
              SpendingScreen(
                homeModel: model,
              ),
              // Container(),
              ProfileScreenView(
                homeModel: model,
              )
            ],
          ),
          bottomNavigationBar: Container(
            color: Colors.white,
            height: sizeConfig.getPropHeight(56),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                model.tabs.length,
                (index) => InkWell(
                  onTap: () => model.tabChanged(index),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: sizeConfig.getPropHeight(16),
                      horizontal: sizeConfig.getPropWidth(20),
                    ),
                    child: SvgPicture.string(
                      model.tabs[index],
                      color: model.currentTabIndex == index
                          ? const Color(0xFF2128BD)
                          : const Color(0xFF000000),
                    ),
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
