import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/utils/custom_painters/tab_bar_icons/activity_bab_icon.dart';
import 'package:fridayy_one/business_login/utils/custom_painters/tab_bar_icons/chart_tab_icon.dart';
import 'package:fridayy_one/business_login/utils/custom_painters/tab_bar_icons/home_tab_icon.dart';
import 'package:fridayy_one/business_login/utils/custom_painters/tab_bar_icons/offer_tab_icon.dart';
import 'package:fridayy_one/business_login/utils/custom_painters/tab_bar_icons/profile_tab_icon.dart';
import 'package:fridayy_one/business_login/view_models/HomeViewModels/home_screen_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/base_view.dart';
import 'package:fridayy_one/ui/widgets/draw.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/coupon_card.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/doughnut_chart.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/expense_chips.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/offer.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/offer_meter.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/usp_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeScreenViewModel>(
      builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
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
                InkWell(
                  onTap: model.gotoNotifications,
                  child: Image.asset('assets/images/notification_icon.png'),
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
            ),
            body: SingleChildScrollView(
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
                            topLeft:
                                Radius.circular(sizeConfig.getPropWidth(16)),
                            topRight:
                                Radius.circular(sizeConfig.getPropWidth(16)),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: sizeConfig.getPropHeight(104),
                            ),
                            SizedBox(
                              width: sizeConfig.getPropWidth(379),
                              height: sizeConfig.getPropHeight(95),
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: model.couponData.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return CouponCard(
                                    coupon: model.couponData[index],
                                    size: 76,
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    width: sizeConfig.getPropWidth(16),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: sizeConfig.getPropHeight(20),
                            ),
                            USPTile(
                              uspName: 'Spending Behaviour',
                              onTap: model.gotoSpendingBehaviour,
                            ),
                            SizedBox(
                              height: sizeConfig.getPropHeight(22.5),
                            ),
                            Container(
                              height: sizeConfig.getPropHeight(187),
                              width: sizeConfig.getPropWidth(379),
                              padding:
                                  EdgeInsets.all(sizeConfig.getPropWidth(20)),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  sizeConfig.getPropWidth(16),
                                ),
                              ),
                              child: InkWell(
                                onTap: model.gotoSpendingBehaviour,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: sizeConfig.getPropHeight(79),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Text('September'),
                                              const Text('Rs. 540.00')
                                            ],
                                          ),
                                          DoughnutChart(
                                            size: 79,
                                            data: model.data,
                                            onTap: model.gotoOffers,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(),
                                    const Spacer(),
                                    ExpenseChips(
                                      data: model.data,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: sizeConfig.getPropHeight(20),
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
                      Center(
                        child: Container(
                          height: sizeConfig.getPropHeight(169),
                          width: sizeConfig.getPropWidth(379),
                          padding: EdgeInsets.only(
                            left: sizeConfig.getPropWidth(32.65),
                            right: sizeConfig.getPropWidth(6),
                            top: sizeConfig.getPropWidth(20.15),
                            bottom: sizeConfig.getPropWidth(20.15),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              sizeConfig.getPropWidth(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  OfferMeter(
                                    size: 90,
                                    onTap: model.gotoOffers,
                                  ),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    child: const Text(
                                      'Total Offers',
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Offer(
                                    onTap: model.gotoActiveOffers,
                                    offerCount: 1745,
                                    isExpiredOffer: false,
                                    height: 24,
                                  ),
                                  SizedBox(
                                    height: sizeConfig.getPropWidth(44),
                                  ),
                                  Offer(
                                    onTap: model.gotoExpiredOffers,
                                    offerCount: 225,
                                    isExpiredOffer: true,
                                    height: 24,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              color: Colors.white,
              height: sizeConfig.getPropHeight(56),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Draw(
                      squareSize: 24,
                      painter: HomeTabIcon(),
                    ),
                    Draw(
                      squareSize: 24,
                      painter: OfferTabIcon(),
                    ),
                    Draw(
                      squareSize: 24,
                      painter: ChartTabIcon(),
                    ),
                    Draw(
                      squareSize: 24,
                      painter: ActivityTabIcon(),
                    ),
                    Draw(
                      squareSize: 24,
                      painter: ProfileTabIcon(),
                    ),
                  ]),
            ));
      },
    );
  }
}
