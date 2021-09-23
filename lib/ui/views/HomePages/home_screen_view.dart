import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fridayy_one/business_login/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_login/view_models/HomeViewModels/home_screen_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/base_view.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/offers_card.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/recommended_offers.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/spending_behaviour_card.dart';
import 'package:fridayy_one/ui/widgets/usp_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeScreenViewModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
            appBar: model.currentTabIndex == 0
                ? AppBar(
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                    centerTitle: false,
                    automaticallyImplyLeading: false,
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: sizeConfig.getPropHeight(21),
                          child: Text(
                            'Hello',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: sizeConfig.getPropHeight(32),
                          child: Text(
                            'Alexandera Bill',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: sizeConfig.getPropWidth(27),
                        ),
                        child: InkWell(
                          onTap: model.gotoNotifications,
                          child: SvgPicture.string(
                            FridayySvg.notificationIcon,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: sizeConfig.getPropWidth(16),
                        ),
                        child: InkWell(
                          onTap: model.gotoProfile,
                          child: const CircleAvatar(
                            backgroundImage:
                                NetworkImage('https://i.pravatar.cc/300'),
                          ),
                        ),
                      ),
                    ],
                  )
                : AppBar(
                    automaticallyImplyLeading: false,
                  ),
            body: PageView.builder(
                controller: model.pageController,
                itemCount: model.tabs.length,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                USPTile(
                                  uspName: 'Offers',
                                  onTap: model.gotoOffers,
                                ),
                                SizedBox(
                                  height: sizeConfig.getPropHeight(22.5),
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    top: sizeConfig.getPropHeight(85),
                                    bottom: 0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE9E9E9),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          sizeConfig.getPropWidth(16)),
                                      topRight: Radius.circular(
                                          sizeConfig.getPropWidth(16)),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      RecommendedOffers(
                                          couponData: model.couponData),
                                      USPTile(
                                        uspName: 'Spending Behaviour',
                                        onTap: model.gotoSpendingBehaviour,
                                      ),
                                      SpendingBehaviourCard(
                                        chartData: model.data,
                                        onTap: model.gotoSpendingBehaviour,
                                      ),
                                      USPTile(
                                        uspName: 'Finance Analytics',
                                        onTap: model.gotoFinanceAnalytics,
                                      ),
                                      SizedBox(
                                        height: sizeConfig.getPropHeight(100),
                                      ),
                                    ],
                                  ),
                                ),
                                OfferCard(
                                  totalOffers: model.totalOffers,
                                  activeOffers: model.activeOffers,
                                  inActiveOffers: model.expiredOffers,
                                  onTap: model.gotoOffers,
                                  onActiveTap: model.gotoActiveOffers,
                                  onExpiredTap: model.gotoExpiredOffers,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );

                    default:
                      return Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      );
                  }
                }),
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
            ));
      },
    );
  }
}
