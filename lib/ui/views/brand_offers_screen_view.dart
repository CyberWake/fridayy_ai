import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fridayy_one/business_login/models/user_overview_model.dart';
import 'package:fridayy_one/business_login/utils/fridayy_svg.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/display_offer.dart';

class BrandOffersView extends StatelessWidget {
  const BrandOffersView({
    Key? key,
    required this.offers,
    required this.brandData,
  }) : super(key: key);
  final List<Offers> offers;
  final List brandData;

  Widget getOfferImage(
    BuildContext context, {
    required String name,
  }) {
    for (int i = 0; i < brandData.length; i++) {
      if (brandData[i]['brandName'].toString() == name) {
        return Image.memory(
          base64.decode(brandData[i]['brandImg'].toString().split(',').last),
          scale: 1,
        );
      }
    }
    return Image.network('');
  }

  Widget offerInfo(BuildContext context, String infoName, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          infoName,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 13,
                color: const Color(0xFF71828A),
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 13,
                color: const Color(0xFF71828A),
              ),
        ),
      ],
    );
  }

  showCouponDetails(Offers offerDetails) async {
    showModalBottomSheet(
      context: navigationService.navigatorKey.currentContext!,
      constraints: BoxConstraints(
        maxWidth: sizeConfig.getPropWidth(336),
        minHeight: sizeConfig.getPropHeight(514),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
        child: DisplayOffer(
          offerInfo: offerDetails,
          showClaimButton: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9F9),
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
            size: 20,
          ),
          onPressed: () => navigationService.pop(),
        ),
        title: Text(
          offers[0].brandName,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 22, color: Colors.grey),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: sizeConfig.getPropWidth(16),
              vertical: sizeConfig.getPropHeight(16),
            ),
            height: sizeConfig.getPropHeight(84),
            child: Row(
              children: [
                Container(
                  height: sizeConfig.getPropHeight(48),
                  width: sizeConfig.getPropWidth(310),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                    left: sizeConfig.getPropHeight(8),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE7ECEE)),
                    borderRadius: BorderRadius.circular(
                      sizeConfig.getPropWidth(16),
                    ),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Search',
                      prefixIconConstraints: BoxConstraints(
                        maxHeight: sizeConfig.getPropHeight(24),
                        maxWidth: sizeConfig.getPropWidth(24),
                      ),
                      prefixIcon: SvgPicture.string(
                        FridayySvg.searchIcon,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: sizeConfig.getPropWidth(12),
                    ),
                    child: SvgPicture.string(
                      FridayySvg.filterIcon,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(sizeConfig.getPropWidth(16)),
              itemCount: offers.length,
              itemBuilder: (context, index) {
                return Material(
                  borderRadius: BorderRadius.circular(
                    sizeConfig.getPropHeight(5),
                  ),
                  color: const Color(0xFFE7ECEE),
                  child: InkWell(
                    onTap: () => showCouponDetails(offers[index]),
                    child: Container(
                      height: sizeConfig.getPropHeight(99),
                      width: sizeConfig.getPropWidth(379),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFE7ECEE),
                        ),
                        borderRadius: BorderRadius.circular(
                          sizeConfig.getPropHeight(5),
                        ),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: getOfferImage(
                              context,
                              name: offers[index].brandName,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: sizeConfig.getPropHeight(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    offers[index].rewardType == 'DISCOUNT'
                                        ? '${offers[index].rewardAmount} %OFF'
                                        : 'Rs. ${offers[index].rewardAmount}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                  ),
                                  Text(
                                    offers[index].rewardDescription ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 12,
                                          color: const Color(0xFF9399A3),
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    offers[index].expiryDate ??
                                        'Never Expiring',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: sizeConfig.getPropHeight(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
