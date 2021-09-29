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

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.homeModel}) : super(key: key);
  final HomeScreenHolderViewModel homeModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeScreenViewModel>(
      builder: (context,model,child){
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
              child: InkWell(
                onTap: homeModel.gotoProfile,
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
                    onTap: homeModel.gotoOffers,
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
                          sizeConfig.getPropWidth(16),),
                        topRight: Radius.circular(
                          sizeConfig.getPropWidth(16),),
                      ),
                    ),
                    child: Column(
                      children: [
                        RecommendedOffers(
                          couponData: model.couponData,),
                        USPTile(
                          uspName: 'Spending Behaviour',
                          onTap: homeModel.gotoSpendingBehaviour,
                        ),
                        SpendingBehaviourCard(
                          chartData: model.data,
                          onTap: homeModel.gotoSpendingBehaviour,
                        ),
                        USPTile(
                          uspName: 'Finance Analytics',
                          onTap: homeModel.gotoFinanceAnalytics,
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
                    onTap: homeModel.gotoOffers,
                    onActiveTap: model.gotoActiveOffers,
                    onExpiredTap: model.gotoExpiredOffers,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },);
  }
}
