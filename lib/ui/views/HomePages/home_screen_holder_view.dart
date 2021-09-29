import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fridayy_one/business_login/view_models/HomeViewModels/home_screen_holder_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/HomePages/home_screen_view.dart';
import 'package:fridayy_one/ui/views/HomePages/offer_screen_view.dart';
import 'package:fridayy_one/ui/views/HomePages/spending_screen_view.dart';
import 'package:fridayy_one/ui/views/base_view.dart';

class HomeScreenHolder extends StatelessWidget {
  const HomeScreenHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeScreenHolderViewModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          body: PageView.builder(
            controller: model.pageController,
            itemCount: model.tabs.length,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return HomeScreen(homeModel: model);
                case 1:
                  return OfferScreen(
                    homeModel: model,
                  );
                case 2:
                  return SpendingScreen(
                    homeModel: model,
                  );
                default:
                  return Container();
              }
            },
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
        );
      },
    );
  }
}
