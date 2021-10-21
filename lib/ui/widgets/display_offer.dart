import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/models/user_overview_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/offer_info_tile.dart';
import 'package:fridayy_one/ui/widgets/rounded_rectangular_button.dart';
import 'package:url_launcher/url_launcher.dart';

class DisplayOffer extends StatefulWidget {
  const DisplayOffer({
    Key? key,
    required this.offerInfo,
    this.showClaimButton = false,
  }) : super(key: key);
  final Offers offerInfo;
  final bool showClaimButton;

  @override
  State<DisplayOffer> createState() => _DisplayOfferState();
}

class _DisplayOfferState extends State<DisplayOffer> {
  late List brandData = [];

  @override
  void initState() {
    super.initState();
    loadAssets();
  }

  loadAssets() async {
    final String data = await DefaultAssetBundle.of(
      navigationService.navigatorKey.currentContext!,
    ).loadString("assets/brand_data.json");
    brandData = jsonDecode(data) as List;
    setState(() {});
  }

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
    return Image.network('https://via.placeholder.com/150');
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
                  child: getOfferImage(
                    context,
                    name: widget.offerInfo.brandName,
                  ),
                ),
                Text(
                  widget.offerInfo.rewardAmount != null
                      ? widget.offerInfo.rewardType == 'DISCOUNT'
                          ? '${widget.offerInfo.rewardAmount}% OFF'
                          : 'Rs. ${widget.offerInfo.rewardAmount}'
                      : '',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                ),
                Expanded(
                  child: Text(
                    widget.offerInfo.body,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 12,
                          color: const Color(0xFF9399A3),
                        ),
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
                  value: widget.offerInfo.code,
                ),
                OfferInfoTile(
                  infoName: 'Coupon Link',
                  value: widget.offerInfo.link,
                ),
                OfferInfoTile(
                  infoName: 'Offer Validity',
                  value: widget.offerInfo.expiryDate,
                ),
                OfferInfoTile(
                  infoName: 'Other Info',
                  value: widget.offerInfo.rewardDescription,
                ),
              ],
            ),
          ),
          if (widget.showClaimButton)
            SizedBox(
              height: sizeConfig.getPropHeight(17),
            ),
          if (widget.showClaimButton)
            CustomRoundRectButton(
              onTap: () async {
                navigationService.pop();
                if (widget.offerInfo.code != null) {
                  FlutterClipboard.copy(widget.offerInfo.code!).whenComplete(
                    () => navigationService.showSnackBar('Coupon Code copied'),
                  );
                } else if (widget.offerInfo.link != null) {
                  await canLaunch(widget.offerInfo.link!)
                      ? await launch(widget.offerInfo.link!)
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
          if (widget.showClaimButton)
            SizedBox(
              height: sizeConfig.getPropHeight(56),
            ),
        ],
      ),
    );
  }
}
