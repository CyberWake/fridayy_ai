import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fridayy_one/business_logic/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_logic/view_models/HomeViewModels/home_screen_holder_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/HomeViewModels/home_screen_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/base_view.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/offer_card.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/recommended_offers.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/spending_behaviour_card.dart';
import 'package:fridayy_one/ui/widgets/shimmer_card.dart';
import 'package:fridayy_one/ui/widgets/usp_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.homeModel, this.isAutoLogin = true})
      : super(key: key);
  final HomeScreenHolderViewModel homeModel;
  final bool isAutoLogin;

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeScreenViewModel>(
      onModelReady: (model) => model.init(isAutoLogin: isAutoLogin),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFE5E5E5),
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
                  child: model.isBusy
                      ? const ShimmerCard(
                          size: Size(50, 32),
                          borderRadius: 8,
                          isCenter: false,
                        )
                      : Text(
                          model.userOverView!.user.userName,
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
                  onTap: homeModel.gotoNotifications,
                  child: SvgPicture.string(
                    FridayySvg.notificationIcon,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: sizeConfig.getPropWidth(16),
                ),
                child: model.isBusy
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: sizeConfig.getPropHeight(10),
                        ),
                        child: const ShimmerCard(
                          size: Size(40, 35),
                          borderRadius: 20,
                          isCenter: false,
                        ),
                      )
                    : InkWell(
                        onTap: homeModel.gotoProfile,
                        child: CircleAvatar(
                          child: Text(
                            model.isBusy
                                ? "..."
                                : model.userOverView!.user.userName
                                    .substring(0, 1)
                                    .toUpperCase(),
                          ),
                        ),
                      ),
              ),
            ],
          ),
          body: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            edgeOffset: 0.0,
            strokeWidth: 0.0,
            onRefresh: model.postSms,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      USPTile(
                        uspName: 'Offers',
                        onTap: homeModel.gotoOffers,
                      ),
                      SizedBox(
                        height: sizeConfig.getPropHeight(22.5),
                      ),
                    ],
                  ),
                  model.isBusy
                      ? const ShimmerCard(
                          size: Size(379, 365),
                          borderRadius: 16,
                        )
                      : OffersInfoWidgets(
                          offersData: model.userOverView!.offers,
                          onTap: homeModel.gotoOffers,
                        ),
                  Column(
                    children: [
                      StoryListOffers(
                        offers:
                            model.userOverView?.offers.recommendedOffers ?? [],
                        isLoading: model.isBusy,
                      ),
                      USPTile(
                        uspName: 'Spending Behaviour',
                        onTap: homeModel.gotoSpendingBehaviour,
                      ),
                      model.isBusy
                          ? const ShimmerCard(
                              size: Size(379, 587),
                              borderRadius: 16,
                              marginTop: 22.5,
                            )
                          : SpendingBehaviourCard(
                              spendingData: model.userOverView!.spending,
                              onTap: homeModel.gotoSpendingBehaviour,
                            ),
                      USPTile(
                        uspName: 'Finance Analytics',
                        onTap: homeModel.gotoFinanceAnalytics,
                      ),
                      model.isBusy
                          ? const ShimmerCard(
                              size: Size(379, 169),
                              borderRadius: 16,
                              marginTop: 22.5,
                            )
                          : Container(
                              height: sizeConfig.getPropHeight(190),
                              width: sizeConfig.getPropWidth(379),
                              margin: EdgeInsets.only(
                                top: sizeConfig.getPropHeight(22.5),
                              ),
                              padding: EdgeInsets.all(
                                sizeConfig.getPropWidth(20),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  sizeConfig.getPropWidth(16),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Wow ${model.userOverView!.user.userName}\nyour spending score is better than 98% of users',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                      SizedBox(
                        height: sizeConfig.getPropHeight(22.5),
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
