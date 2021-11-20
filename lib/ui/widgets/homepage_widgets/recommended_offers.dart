import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/user_overview_model.dart';
import 'package:fridayy_one/business_logic/utils/routing_constants.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/shimmer_card.dart';

class RecommendedOffers extends StatelessWidget {
  const RecommendedOffers({
    Key? key,
    required this.offers,
    required this.brandData,
    required this.isLoading,
  }) : super(key: key);
  final List<NotifiedOffers> offers;
  final List brandData;
  final bool isLoading;

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
        itemCount: isLoading ? 4 : offers.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (isLoading) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sizeConfig.getPropWidth(8),
              ),
              child: const ShimmerCard(
                size: Size(76, 76),
                borderRadius: 50,
                isCircle: true,
              ),
            );
          }
          final NotifiedOffers offer = offers[index];
          return InkWell(
            onTap: () => navigationService.pushScreen(
              Routes.storyScreen,
              arguments: {"offers": offers, "startIndex": index},
            ),
            child: Padding(
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
                        color: getCouponBorderColor(
                          offer.expiryDate != null
                              ? DateTime.now()
                                  .difference(
                                    DateTime.fromMillisecondsSinceEpoch(
                                      offer.expiryDate!,
                                    ),
                                  )
                                  .inDays
                              : -1,
                        ),
                        width: 2,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://friday-images.s3.ap-south-1.amazonaws.com/${offer.brandId}.jpeg',
                        ),
                        fit: BoxFit.none,
                        scale: 6,
                      ),
                    ),
                  ),
                  Text(
                    offer.brandName,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontSize: 11),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
