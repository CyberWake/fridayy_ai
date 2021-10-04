import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/models/user_overview_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class RecommendedOffers extends StatelessWidget {
  const RecommendedOffers({
    Key? key,
    required this.offers,
    required this.brandData,
  }) : super(key: key);
  final List<NotifiedOffers> offers;
  final List brandData;
  Color getCouponBorderColor(int expiry) {
    switch (expiry) {
      case 0:
        return Colors.grey;
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow;
      default:
        return Colors.green;
    }
  }

  ImageProvider getOfferImage(
    BuildContext context, {
    required String name,
  }) {
    for (int i = 0; i < brandData.length; i++) {
      if (brandData[i]['brandName'].toString() == name) {
        return MemoryImage(
          base64.decode(brandData[i]['brandImg'].toString().split(',').last),
        );
      }
    }
    return const AssetImage('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: sizeConfig.getPropHeight(104),
      ),
      width: sizeConfig.getPropWidth(379),
      height: sizeConfig.getPropHeight(95),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: offers.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final NotifiedOffers offer = offers[index];
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: sizeConfig.getPropWidth(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: sizeConfig.getPropHeight(76),
                  width: sizeConfig.getPropWidth(76),
                  padding: EdgeInsets.all(sizeConfig.getPropWidth(1)),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: getCouponBorderColor(offer.relativeDay),
                      width: 2,
                    ),
                    image: DecorationImage(
                      image:
                          getOfferImage(context, name: offer.offers!.brandName),
                      fit: BoxFit.none,
                      scale: 6,
                    ),
                  ),

                  // child: CircleAvata r(
                  //   //backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
                  //   backgroundImage:
                  //       getOfferImage(context, name: offer.offers!.brandName),
                  // ),
                ),
                Text(
                  offer.offers!.brandName,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 11),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
