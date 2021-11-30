import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fridayy_one/business_logic/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/dashboard/home_screen_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/home_screen_holder_view_model.dart';
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
      onModelReady: (model) =>
          model.init(isAutoLogin: isAutoLogin, model: homeModel),
      builder: (context, model, child) {
        return Scaffold(
          // backgroundColor: const Color(0xFFE5E5E5),
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            centerTitle: false,
            automaticallyImplyLeading: false,
            toolbarHeight: 60,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: sizeConfig.getPropHeight(20),
                  child: Text(
                    'Hello,',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: sizeConfig.getPropHeight(30),
                  child: model.isBusy && homeModel.userOverView == null
                      ? const ShimmerCard(
                          size: Size(60, 30),
                          borderRadius: 4,
                          isCenter: false,
                        )
                      : Text(
                          homeModel.userOverView!.user.userName.split(' ')[0],
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: const Color(0xFF202046)),
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
                child: model.isBusy && homeModel.userOverView == null
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: sizeConfig.getPropHeight(10),
                        ),
                        child: const ShimmerCard(
                          size: Size(40, 40),
                          borderRadius: 20,
                          isCenter: false,
                        ),
                      )
                    : InkWell(
                        onTap: homeModel.gotoProfile,
                        child: CircleAvatar(
                          child: Text(
                            homeModel.userOverView!.user.userName
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
                        onTap: () => homeModel.gotoOffers(0),
                      ),
                      SizedBox(
                        height: sizeConfig.getPropHeight(22.5),
                      ),
                    ],
                  ),
                  model.isBusy && homeModel.userOverView == null
                      ? const ShimmerCard(
                          size: Size(379, 365),
                          borderRadius: 16,
                        )
                      : OffersInfoWidgets(
                          offersData: homeModel.userOverView!.offers,
                          onTap: homeModel.gotoOffers,
                          activePage: homeModel.overViewActiveCard,
                          homeModel: homeModel,
                        ),
                  Column(
                    children: [
                      StoryListOffers(
                        offers:
                            homeModel.userOverView?.offers.recommendedOffers! ??
                                [],
                        isLoading:
                            model.isBusy && homeModel.userOverView == null,
                      ),
                      USPTile(
                        uspName: 'Spending Behaviour',
                        onTap: homeModel.gotoSpendingBehaviour,
                      ),
                      model.isBusy && homeModel.userOverView == null
                          ? const ShimmerCard(
                              size: Size(379, 587),
                              borderRadius: 16,
                              marginTop: 22.5,
                            )
                          : SpendingBehaviourCard(
                              spendingData: homeModel.userOverView!.spending,
                              onTap: homeModel.gotoSpendingBehaviour,
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
