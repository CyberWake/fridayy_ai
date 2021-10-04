import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fridayy_one/business_login/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_login/view_models/HomeViewModels/home_screen_holder_view_model.dart';
import 'package:fridayy_one/business_login/view_models/HomeViewModels/home_screen_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/base_view.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/offers_card.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/recommended_offers.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/spending_behaviour_card.dart';
import 'package:fridayy_one/ui/widgets/usp_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.homeModel}) : super(key: key);
  final HomeScreenHolderViewModel homeModel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BaseView<HomeScreenViewModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
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
                    model.userOverView.user.userName,
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
                  onTap: widget.homeModel.gotoNotifications,
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
                  onTap: widget.homeModel.gotoProfile,
                  child: CircleAvatar(
                    child: Text(
                      model.userOverView.user.userName.isEmpty
                          ? "..."
                          : model.userOverView.user.userName
                              .substring(0, 1)
                              .toUpperCase(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: model.init,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      USPTile(
                        uspName: 'Offers',
                        onTap: widget.homeModel.gotoOffers,
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
                              sizeConfig.getPropWidth(16),
                            ),
                            topRight: Radius.circular(
                              sizeConfig.getPropWidth(16),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            RecommendedOffers(
                              brandData: widget.homeModel.brandData,
                              offers: model.userOverView.offer.notifiedOffers,
                            ),
                            USPTile(
                              uspName: 'Spending Behaviour',
                              onTap: widget.homeModel.gotoSpendingBehaviour,
                            ),
                            SpendingBehaviourCard(
                              spendingData: model.userOverView.spending,
                              onTap: widget.homeModel.gotoSpendingBehaviour,
                            ),
                            USPTile(
                              uspName: 'Finance Analytics',
                              onTap: widget.homeModel.gotoFinanceAnalytics,
                            ),
                            Container(
                              height: sizeConfig.getPropHeight(190),
                              width: sizeConfig.getPropWidth(379),
                              margin: EdgeInsets.only(
                                top: sizeConfig.getPropHeight(22.5),
                              ),
                              padding:
                                  EdgeInsets.all(sizeConfig.getPropWidth(20)),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  sizeConfig.getPropWidth(16),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Wow ${model.userOverView.user.userName}\nyour spending score is better than ${model.userOverView.financial.percentile}% of users',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            SizedBox(
                              height: sizeConfig.getPropHeight(22.5),
                            ),
                          ],
                        ),
                      ),
                      OfferCard(
                        totalOffers:
                            model.userOverView.offer.totalOffers.toDouble(),
                        activeOffers:
                            model.userOverView.offer.activeOffers.toDouble(),
                        inActiveOffers:
                            model.userOverView.offer.offersExpiring.toDouble(),
                        onTap: widget.homeModel.gotoOffers,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
