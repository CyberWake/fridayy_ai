import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/new_user_overview_model.dart';
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
  final List<OffersByBrand> offers;
  final List brandData;
  final bool isLoading;

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
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF2128BD)),
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://friday-images.s3.ap-south-1.amazonaws.com/${offers[index].brandId}.jpeg',
                        ),
                        fit: BoxFit.none,
                        scale: 6,
                      ),
                    ),
                  ),
                  Text(
                    offers[index].brandName,
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
