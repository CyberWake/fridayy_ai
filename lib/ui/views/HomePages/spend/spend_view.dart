import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fridayy_one/business_logic/models/spends_model.dart';
import 'package:fridayy_one/business_logic/utils/extensions.dart';
import 'package:fridayy_one/business_logic/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/spends/spend_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/HomePages/spend/edit_spend_view.dart';
import 'package:fridayy_one/ui/views/base_view.dart';
import 'package:fridayy_one/ui/widgets/popups/spends/delete_transaction.dart';
import 'package:fridayy_one/ui/widgets/shimmer_card.dart';

class SpendView extends StatelessWidget {
  const SpendView({Key? key, required this.spendId}) : super(key: key);
  final String spendId;

  Widget buildItems({
    Color borderColor = const Color(0xFF2128BD),
    required String svgImage,
    String? url,
    required String label,
  }) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          left: sizeConfig.getPropWidth(12),
        ),
        child: Row(
          children: [
            Container(
              height: sizeConfig.getPropWidth(44),
              width: sizeConfig.getPropWidth(44),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 0.5, color: borderColor),
              ),
              child: SvgPicture.string(
                svgImage,
                height: 36,
                width: 36,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: sizeConfig.getPropWidth(28),
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: Theme.of(navigationService.navigatorKey.currentContext!)
                    .textTheme
                    .caption!
                    .copyWith(
                      color: Colors.black,
                      fontSize: 16,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }

  showDeletePopUp(SpendsModel spend) async {
    showModalBottomSheet(
      context: navigationService.navigatorKey.currentContext!,
      constraints: BoxConstraints(
        maxWidth: sizeConfig.getPropWidth(379),
        minHeight: sizeConfig.getPropHeight(351),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
        child: Center(
          child: DeleteTransaction(spend: spend),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SpendViewModel>(
      onModelReady: (model) => model.init(spendId),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: const Color(0xFFF9F9F9),
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
                size: 20,
              ),
              onPressed: () => navigationService.pop(),
            ),
            title: Text(
              model.isBusy ? '' : model.spend.brandName!,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 20, color: Colors.black),
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
            ],
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: sizeConfig.getPropHeight(70),
                padding: EdgeInsets.symmetric(
                  horizontal: sizeConfig.getPropWidth(45),
                ),
                color: const Color(0xFFF9F9F9),
                child: model.isBusy
                    ? const ShimmerCard(size: Size(411, 70), borderRadius: 4)
                    : Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.isBusy
                                    ? ''
                                    : 'Rs. ${model.spend.amount.toString()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontSize: 20,
                                      color: const Color(0xFF2128BD),
                                    ),
                              ),
                              Text(
                                model.isBusy ? '' : model.spend.date!.toDate(),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () => showDeletePopUp(model.spend),
                            child: SvgPicture.string(
                              FridayySvg.deleteIcon,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: sizeConfig.getPropWidth(26),
                          ),
                          OpenContainer(
                            closedBuilder: (context, onTap) {
                              return SvgPicture.string(
                                FridayySvg.editIcon,
                              );
                            },
                            openBuilder: (context, onTap) {
                              return EditSpendView(
                                spendInfo: model.spend,
                              );
                            },
                            transitionDuration:
                                const Duration(milliseconds: 750),
                            closedElevation: 0.0,
                            openElevation: 0.0,
                            tappable: true,
                            closedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            closedColor: Colors.transparent,
                          ),
                        ],
                      ),
              ),
              Container(
                height: sizeConfig.getPropHeight(252),
                width: sizeConfig.getPropWidth(379),
                margin: EdgeInsets.symmetric(
                  horizontal: sizeConfig.getPropWidth(16),
                  vertical: sizeConfig.getPropHeight(16),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: sizeConfig.getPropWidth(20),
                  vertical: sizeConfig.getPropHeight(20),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    sizeConfig.getPropWidth(16),
                  ),
                  border: Border.all(
                    color: const Color(0xFFE7ECEE),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    model.isBusy
                        ? const Expanded(
                            child: ShimmerCard(
                              size: Size(359, 40),
                              borderRadius: 8,
                            ),
                          )
                        : buildItems(
                            svgImage: model.spend.categoryId!.getSvg(),
                            label: model.spend.categoryId!.getName(),
                          ),
                    const Divider(),
                    model.isBusy
                        ? const Expanded(
                            child: ShimmerCard(
                              size: Size(359, 40),
                              borderRadius: 8,
                            ),
                          )
                        : buildItems(
                            svgImage: model.spend.paymentType!.getSvg(),
                            label: model.spend.paymentType!,
                          ),
                    const Divider(),
                    model.isBusy
                        ? const Expanded(
                            child: ShimmerCard(
                              size: Size(359, 40),
                              borderRadius: 8,
                            ),
                          )
                        : buildItems(
                            svgImage: FridayySvg.messageIcon,
                            label: model.spend.address!,
                          ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  height: model.isBusy ? 144 : null,
                  margin: EdgeInsets.symmetric(
                    horizontal: sizeConfig.getPropWidth(16),
                    vertical: sizeConfig.getPropHeight(16),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      sizeConfig.getPropWidth(16),
                    ),
                    border: Border.all(
                      color: const Color(0xFFE7ECEE),
                    ),
                    color: Colors.white,
                  ),
                  child: model.isBusy
                      ? const ShimmerCard(
                          size: Size(379, 144),
                          borderRadius: 16,
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: sizeConfig.getPropWidth(20),
                            vertical: sizeConfig.getPropHeight(20),
                          ),
                          child: Text(
                            model.spend.body!,
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                          ),
                        ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
