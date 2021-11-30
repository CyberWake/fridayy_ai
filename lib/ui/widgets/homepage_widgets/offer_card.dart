import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/user_overview_model.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/home_screen_holder_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/offer_overview_cards/loved_brand_card.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/offer_overview_cards/offer_brief_info_card.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/offer_overview_cards/offer_data_visualizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OffersInfoWidgets extends StatefulWidget {
  const OffersInfoWidgets({
    Key? key,
    required this.onTap,
    required this.offersData,
    required this.activePage,
    required this.homeModel,
  }) : super(key: key);
  final void Function(int) onTap;
  final int activePage;
  final Offers offersData;
  final HomeScreenHolderViewModel homeModel;

  @override
  State<OffersInfoWidgets> createState() => _OffersInfoWidgetsState();
}

class _OffersInfoWidgetsState extends State<OffersInfoWidgets> {
  late PageController _controller;
  late HomeScreenHolderViewModel homeModel;

  Widget _buildChild(BuildContext context, int pageIndex) {
    if (widget.offersData.lovedBrand == null &&
        (widget.offersData.sortedCategories?.isEmpty ?? true) &&
        pageIndex == 0) {
      return InkWell(
        borderRadius: BorderRadius.circular(
          sizeConfig.getPropWidth(16),
        ),
        onTap: () => widget.onTap(0),
        child: OfferBriefInfoCard(
          notifiedOffers: widget.offersData.notifiedOffers!,
          totalOffers: widget.offersData.totalOffers,
          activeOffers: widget.offersData.activeOffers,
          expiringSoonOffers: widget.offersData.expiringSoonOffers,
        ),
      );
    } else if (widget.offersData.lovedBrand == null && pageIndex == 0) {
      return OfferOverView(
        categories: widget.offersData.sortedCategories!.reversed.toList(),
        totalOffers: widget.offersData.totalOffers.toString(),
        gotoOfferCategory: widget.onTap,
      );
    } else if (widget.offersData.lovedBrand == null && pageIndex == 1) {
      return InkWell(
        borderRadius: BorderRadius.circular(
          sizeConfig.getPropWidth(16),
        ),
        onTap: () => widget.onTap(0),
        child: OfferBriefInfoCard(
          notifiedOffers: widget.offersData.notifiedOffers!,
          totalOffers: widget.offersData.totalOffers,
          activeOffers: widget.offersData.activeOffers,
          expiringSoonOffers: widget.offersData.expiringSoonOffers,
        ),
      );
    } else if (pageIndex == 0) {
      return InkWell(
        borderRadius: BorderRadius.circular(
          sizeConfig.getPropWidth(16),
        ),
        onTap: () => widget.onTap(0),
        child: LovedBrandCard(lovedBrand: widget.offersData.lovedBrand!),
      );
    } else if (pageIndex == 1) {
      return OfferOverView(
        categories: widget.offersData.sortedCategories!.reversed.toList(),
        totalOffers: widget.offersData.totalOffers.toString(),
        gotoOfferCategory: widget.onTap,
      );
    } else if (pageIndex == 2) {
      return InkWell(
        borderRadius: BorderRadius.circular(
          sizeConfig.getPropWidth(16),
        ),
        onTap: () => widget.onTap(0),
        child: OfferBriefInfoCard(
          notifiedOffers: widget.offersData.notifiedOffers!,
          totalOffers: widget.offersData.totalOffers,
          activeOffers: widget.offersData.activeOffers,
          expiringSoonOffers: widget.offersData.expiringSoonOffers,
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  void initState() {
    homeModel = widget.homeModel;
    _controller = PageController(initialPage: widget.activePage);
    _controller.addListener(() {
      homeModel.overViewActiveCard = _controller.page!.round();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: sizeConfig.getPropHeight(340),
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.offersData.lovedBrand == null
                ? widget.offersData.sortedCategories?.isEmpty ?? true
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
                  border: Border.all(color: const Color(0xFFE7ECEE)),
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
          count: widget.offersData.lovedBrand == null
              ? widget.offersData.sortedCategories?.isEmpty ?? true
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
