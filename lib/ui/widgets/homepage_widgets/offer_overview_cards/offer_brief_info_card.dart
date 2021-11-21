import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/new_user_overview_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/charts/charts.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/recommended_offers.dart';

class OfferBriefInfoCard extends StatelessWidget {
  const OfferBriefInfoCard({
    Key? key,
    required this.totalOffers,
    required this.activeOffers,
    required this.expiringSoonOffers,
    required this.notifiedOffers,
  }) : super(key: key);
  final int totalOffers;
  final int activeOffers;
  final int expiringSoonOffers;
  final List<OffersByBrand> notifiedOffers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: sizeConfig.getPropHeight(200),
          width: sizeConfig.getPropWidth(300),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: DoughnutChart(
                  data: [
                    Distribution(
                      categoryId: "ACT",
                      percentage: activeOffers / totalOffers,
                      count: activeOffers,
                    ),
                    Distribution(
                      categoryId: "EXS",
                      percentage: expiringSoonOffers / totalOffers,
                      count: expiringSoonOffers,
                    ),
                    Distribution(
                      categoryId: "EXP",
                      percentage:
                          (totalOffers - (activeOffers + expiringSoonOffers)) /
                              totalOffers,
                      count: totalOffers - (activeOffers + expiringSoonOffers),
                    ),
                  ],
                  size: 231,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(totalOffers.toString()),
              ),
              Positioned(
                bottom: sizeConfig.getPropHeight(20),
                width: sizeConfig.getPropWidth(300),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: const BoxDecoration(
                              color: Color(0xFFB160B7),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text(
                            'Active',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFE600),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text(
                            'Expiring Soon',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF14A25),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text(
                            'Expired',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        StoryListOffers(
          offers: notifiedOffers,
          isLoading: false,
          showGlow: true,
          size: 60,
        ),
      ],
    );
  }
}
