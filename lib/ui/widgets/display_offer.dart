import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/user_overview_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/offer_info_tile.dart';
import 'package:fridayy_one/ui/widgets/rounded_rectangular_button.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DisplayOffer extends StatelessWidget {
  const DisplayOffer({
    Key? key,
    required this.offerInfo,
    this.showClaimButton = false,
    required this.brandId,
  }) : super(key: key);
  final String brandId;
  final OfferInfo offerInfo;
  final bool showClaimButton;

  String getDate() {
    final DateFormat formatter = DateFormat('dd MMM, yyyy');
    return formatter.format(
      DateTime.fromMillisecondsSinceEpoch(offerInfo.expiryDate! * 1000),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeConfig.getPropHeight(555),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: sizeConfig.getPropHeight(192),
            width: sizeConfig.getPropWidth(336),
            padding: EdgeInsets.symmetric(
              horizontal: sizeConfig.getPropWidth(20),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                sizeConfig.getPropHeight(8),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: sizeConfig.getPropHeight(20),
                  ),
                  height: sizeConfig.getPropHeight(49),
                  width: sizeConfig.getPropWidth(113),
                  alignment: Alignment.center,
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://friday-images.s3.ap-south-1.amazonaws.com/$brandId.jpeg',
                    imageBuilder: (context, imageProvider) => Container(
                      height: sizeConfig.getPropHeight(49),
                      width: sizeConfig.getPropWidth(113),
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
                Text(
                  offerInfo.rewardAmount != null
                      ? offerInfo.rewardType == 'DISCOUNT'
                          ? '${offerInfo.rewardAmount}% OFF'
                          : 'Rs. ${offerInfo.rewardAmount}'
                      : '',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                ),
                Expanded(
                  child: Text(
                    offerInfo.body,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 12,
                          color: const Color(0xFF9399A3),
                        ),
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: sizeConfig.getPropHeight(9),
          ),
          Container(
            height: sizeConfig.getPropHeight(192),
            width: sizeConfig.getPropWidth(336),
            padding: EdgeInsets.symmetric(
              horizontal: sizeConfig.getPropWidth(20),
              vertical: sizeConfig.getPropHeight(20),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                sizeConfig.getPropHeight(8),
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Offer Details',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 14, color: Colors.black),
                ),
                OfferInfoTile(
                  infoName: 'Coupon Code',
                  value: offerInfo.code,
                ),
                OfferInfoTile(
                  infoName: 'Coupon Link',
                  value: offerInfo.link,
                ),
                OfferInfoTile(
                  infoName: 'Offer Validity',
                  value: getDate(),
                ),
                OfferInfoTile(
                  infoName: 'Terms and conditions',
                  value: offerInfo.termsAndConditionsApply ? "Applied" : "None",
                ),
                OfferInfoTile(
                  infoName: 'Other Info',
                  value: offerInfo.rewardDescription,
                ),
              ],
            ),
          ),
          if (showClaimButton)
            SizedBox(
              height: sizeConfig.getPropHeight(17),
            ),
          if (showClaimButton)
            CustomRoundRectButton(
              onTap: () async {
                navigationService.pop();
                if (offerInfo.code != null) {
                  FlutterClipboard.copy(offerInfo.code!).whenComplete(
                    () => navigationService.showSnackBar('Coupon Code copied'),
                  );
                }
                if (offerInfo.link != null) {
                  await canLaunch(offerInfo.link!)
                      ? await launch(offerInfo.link!)
                      : navigationService.showSnackBar('Failed to open link');
                }
              },
              size: const Size(335, 44),
              fillColor: const Color(0xFF2128BD),
              child: Text(
                'Claim this offer',
                style: Theme.of(navigationService.navigatorKey.currentContext!)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.white),
              ),
            ),
          if (showClaimButton)
            SizedBox(
              height: sizeConfig.getPropHeight(56),
            ),
        ],
      ),
    );
  }
}
