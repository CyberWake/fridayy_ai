import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/new_models/new_user_overview_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/story_screen_view.dart';
import 'package:fridayy_one/ui/widgets/shimmer_card.dart';

class StoryListOffers extends StatelessWidget {
  const StoryListOffers({
    Key? key,
    required this.offers,
    required this.isLoading,
    this.showGlow,
    this.size,
  }) : super(key: key);
  final List<OffersByBrand> offers;
  final bool isLoading;
  final bool? showGlow;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: sizeConfig.getPropHeight(20),
      ),
      width: sizeConfig.getPropWidth(379),
      height: sizeConfig.getPropHeight(80),
      alignment: Alignment.center,
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
                borderRadius: 10,
                isCircle: false,
              ),
            );
          }
          return OpenContainer(
            transitionDuration: const Duration(milliseconds: 750),
            closedBuilder: (context, onTap) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      sizeConfig.getPropWidth(showGlow ?? false ? 17 : 8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: sizeConfig.getPropHeight(size ?? 76),
                      width: sizeConfig.getPropWidth(size ?? 76),
                      padding: EdgeInsets.all(sizeConfig.getPropWidth(2.5)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: showGlow ?? false
                              ? const Color(0xFFF14A25)
                              : const Color(0xFF2128BD),
                        ),
                        color: Colors.white,
                        boxShadow: showGlow ?? false
                            ? [
                                BoxShadow(
                                  color:
                                      const Color(0xFFF14A25).withOpacity(0.5),
                                  offset: const Offset(2, 2),
                                  blurRadius: 10,
                                )
                              ]
                            : [],
                      ),
                      child: Hero(
                        tag: "${offers[index].brandId}image",
                        child: Image.network(
                          'https://friday-images.s3.ap-south-1.amazonaws.com/${offers[index].brandId}.jpeg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            openBuilder: (context, onTap) {
              return StoryScreenView(
                offers: offers,
                startIndex: index,
              );
            },
            closedElevation: 0.0,
            openElevation: 0.0,
            tappable: true,
            closedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            closedColor: Colors.transparent,
          );
        },
      ),
    );
  }
}
