import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/new_models/new_user_overview_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/offer_overview_cards/loved_brand_card.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/offer_overview_cards/offer_brief_info_card.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/offer_overview_cards/offer_data_visualizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OffersInfoWidgets extends StatelessWidget {
  OffersInfoWidgets({
    Key? key,
    required this.onTap,
    required this.offersData,
  }) : super(key: key);
  final void Function(int) onTap;
  final Offers offersData;

  final PageController _controller = PageController();

  Widget _buildChild(BuildContext context, int pageIndex) {
    if (offersData.lovedBrand == null &&
        (offersData.sortedCategories?.isEmpty ?? true) &&
        pageIndex == 0) {
      return InkWell(
        borderRadius: BorderRadius.circular(
          sizeConfig.getPropWidth(16),
        ),
        onTap: () => onTap(0),
        child: OfferBriefInfoCard(
          notifiedOffers: offersData.notifiedOffers!,
          totalOffers: offersData.totalOffers,
          activeOffers: offersData.activeOffers,
          expiringSoonOffers: offersData.expiringSoonOffers,
        ),
      );
    } else if (offersData.lovedBrand == null && pageIndex == 0) {
      return OfferOverView(
        categories: offersData.sortedCategories!.reversed.toList(),
        totalOffers: offersData.totalOffers.toString(),
        gotoOfferCategory: onTap,
      );
    } else if (offersData.lovedBrand == null && pageIndex == 1) {
      return InkWell(
        borderRadius: BorderRadius.circular(
          sizeConfig.getPropWidth(16),
        ),
        onTap: () => onTap(0),
        child: OfferBriefInfoCard(
          notifiedOffers: offersData.notifiedOffers!,
          totalOffers: offersData.totalOffers,
          activeOffers: offersData.activeOffers,
          expiringSoonOffers: offersData.expiringSoonOffers,
        ),
      );
    } else if (pageIndex == 0) {
      return InkWell(
        borderRadius: BorderRadius.circular(
          sizeConfig.getPropWidth(16),
        ),
        onTap: () => onTap(0),
        child: LovedBrandCard(lovedBrand: offersData.lovedBrand!),
      );
    } else if (pageIndex == 1) {
      return OfferOverView(
        categories: offersData.sortedCategories!.reversed.toList(),
        totalOffers: offersData.totalOffers.toString(),
        gotoOfferCategory: onTap,
      );
    } else if (pageIndex == 2) {
      return InkWell(
        borderRadius: BorderRadius.circular(
          sizeConfig.getPropWidth(16),
        ),
        onTap: () => onTap(0),
        child: OfferBriefInfoCard(
          notifiedOffers: offersData.notifiedOffers!,
          totalOffers: offersData.totalOffers,
          activeOffers: offersData.activeOffers,
          expiringSoonOffers: offersData.expiringSoonOffers,
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: sizeConfig.getPropHeight(340),
          child: PageView.builder(
            controller: _controller,
            itemCount: offersData.lovedBrand == null
                ? offersData.sortedCategories?.isEmpty ?? true
                    ? 1
                    : 2
                : 3,
            itemBuilder: (context, index) => Center(
              child: Container(
                height: sizeConfig.getPropHeight(340),
                width: sizeConfig.getPropWidth(379),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    sizeConfig.getPropWidth(16),
                  ),
                ),
                child: _buildChild(context, index),
              ),
            ),
          ),
        ),
        SizedBox(
          height: sizeConfig.getPropHeight(20),
        ),
        SmoothPageIndicator(
          controller: _controller,
          count: offersData.lovedBrand == null
              ? offersData.sortedCategories?.isEmpty ?? true
                  ? 1
                  : 2
              : 3,
          axisDirection: Axis.horizontal,
          effect: const ScrollingDotsEffect(
            spacing: 8.0,
            radius: 2.5,
            dotWidth: 5.0,
            dotHeight: 5.0,
            paintStyle: PaintingStyle.fill,
            strokeWidth: 1.5,
            dotColor: Colors.grey,
            activeDotColor: Colors.indigo,
            activeDotScale: 2,
          ),
        )
      ],
    );
  }
}
