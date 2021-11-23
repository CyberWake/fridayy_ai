import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fridayy_one/business_logic/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_logic/view_models/brand_offers_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/base_view.dart';
import 'package:fridayy_one/ui/widgets/cards/offer_brand_card.dart';

class BrandOffersView extends StatelessWidget {
  const BrandOffersView({
    Key? key,
    required this.brandId,
    required this.brandName,
  }) : super(key: key);
  final String brandId;
  final String brandName;

  Widget offerInfo(BuildContext context, String infoName, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          infoName,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 13,
                color: const Color(0xFF71828A),
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 13,
                color: const Color(0xFF71828A),
              ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<BrandOffersViewModel>(
      onModelReady: (model) => model.init(brandId),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: const Color(0xFFF9F9F9),
            elevation: 0.0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
                size: 20,
              ),
              onPressed: () => navigationService.pop(),
            ),
            title: Text(
              brandName,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 22, color: Colors.grey),
            ),
          ),
          body: model.isBusy
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: sizeConfig.getPropWidth(16),
                        vertical: sizeConfig.getPropHeight(16),
                      ),
                      height: sizeConfig.getPropHeight(84),
                      child: Row(
                        children: [
                          Container(
                            height: sizeConfig.getPropHeight(48),
                            width: sizeConfig.getPropWidth(310),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(
                              left: sizeConfig.getPropHeight(8),
                            ),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xFFE7ECEE)),
                              borderRadius: BorderRadius.circular(
                                sizeConfig.getPropWidth(16),
                              ),
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: 'Search',
                                prefixIconConstraints: BoxConstraints(
                                  maxHeight: sizeConfig.getPropHeight(24),
                                  maxWidth: sizeConfig.getPropWidth(24),
                                ),
                                prefixIcon: SvgPicture.string(
                                  FridayySvg.searchIcon,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: sizeConfig.getPropWidth(12),
                              ),
                              child: SvgPicture.string(
                                FridayySvg.filterIcon,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.all(sizeConfig.getPropWidth(16)),
                        itemCount: model.brandOffers.offers.length,
                        itemBuilder: (context, index) {
                          final offer = model.brandOffers.offers[index];
                          return OfferBrandCard(
                            offerInfo: offer,
                            brandId: brandId,
                            brandName: brandName,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                          height: sizeConfig.getPropHeight(16),
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
