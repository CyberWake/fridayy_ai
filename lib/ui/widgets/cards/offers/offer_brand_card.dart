import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipboard/clipboard.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fridayy_one/business_logic/models/new_models/new_user_overview_model.dart';
import 'package:fridayy_one/business_logic/utils/fridayy_svg.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/display_offer.dart';

class OfferBrandCard extends StatelessWidget {
  const OfferBrandCard({
    Key? key,
    required this.offerInfo,
    required this.brandId,
    required this.brandName,
  }) : super(key: key);
  final OfferInfo offerInfo;
  final String brandId;
  final String brandName;

  showCouponDetails(OfferInfo offerInfoDetails) async {
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
          offerInfo: offerInfoDetails,
          showClaimButton: true,
          brandId: brandId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(
        sizeConfig.getPropHeight(5),
      ),
      color: const Color(0xFFE7ECEE),
      child: InkWell(
        onTap: () => showCouponDetails(offerInfo),
        child: Container(
          height: sizeConfig.getPropHeight(120),
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
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://friday-images.s3.ap-south-1.amazonaws.com/$brandId.jpeg',
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: sizeConfig.getPropHeight(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        brandName,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: offerInfo.rewardType == 'DISCOUNT'
                                  ? '${offerInfo.rewardAmount}% OFF'
                                  : 'Rs. ${offerInfo.rewardAmount}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: const Color(
                                      0xFF46B62A,
                                    ),
                                    fontSize: 14,
                                  ),
                            ),
                            TextSpan(
                              text:
                                  "  ${DateTime.fromMillisecondsSinceEpoch(offerInfo.expiryDate!).difference(DateTime.now()).inDays} Days",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: const Color(
                                      0xFFCF1E43,
                                    ),
                                    fontSize: 14,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          offerInfo.body,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 12,
                                    color: const Color(0xFF9399A3),
                                  ),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    0,
                    sizeConfig.getPropWidth(14),
                    sizeConfig.getPropHeight(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () =>
                            navigationService.showSnackBar('To be implemented'),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: sizeConfig.getPropHeight(10),
                            bottom: sizeConfig.getPropHeight(10),
                          ),
                          child: SvgPicture.string(FridayySvg.iButtonIcon),
                        ),
                      ),
                      SizedBox(
                        height: sizeConfig.getPropHeight(10),
                      ),
                      if (offerInfo.code != null)
                        DottedBorder(
                          color: const Color(0xFF7B7B7B),
                          strokeWidth: 1,
                          dashPattern: [9, 3],
                          radius: const Radius.circular(20),
                          child: GestureDetector(
                            onTap: () {
                              if (offerInfo.code != null) {
                                FlutterClipboard.copy(offerInfo.code!)
                                    .whenComplete(
                                  () => navigationService
                                      .showSnackBar('Coupon Code copied'),
                                );
                              } else {
                                navigationService
                                    .showSnackBar('Coupon Code not present');
                              }
                            },
                            child: SizedBox(
                              height: sizeConfig.getPropHeight(46),
                              width: sizeConfig.getPropWidth(86),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    offerInfo.code ?? "NA",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 11,
                                          color: Colors.black,
                                        ),
                                  ),
                                  Text(
                                    "Tap to copy",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 6,
                                          color: Colors.black,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
