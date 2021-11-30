import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fridayy_one/business_logic/utils/extensions.dart';
import 'package:fridayy_one/business_logic/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/home_screen_holder_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/offers/offer_screen_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/HomePages/Offer/brand_offers_screen_view.dart';
import 'package:fridayy_one/ui/views/base_view.dart';
import 'package:fridayy_one/ui/widgets/shimmer_card.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({Key? key, required this.homeModel}) : super(key: key);
  final HomeScreenHolderViewModel homeModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<OfferScreenViewModel>(
      onModelReady: (model) => model.init(homeModel),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: const Color(0xFFF9F9F9),
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: Text(
              model.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 20, color: Colors.black),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(
                  right: sizeConfig.getPropWidth(27),
                ),
                child: InkWell(
                  onTap: homeModel.gotoNotifications,
                  child: SvgPicture.string(
                    FridayySvg.notificationIcon,
                  ),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
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
                            onTap: () => model.useFilter(),
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
                    if (model.filterViewBy == "Brand")
                      SizedBox(
                        height: sizeConfig.getPropHeight(65),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: model.types.length,
                          padding: EdgeInsets.symmetric(
                            horizontal: sizeConfig.getPropWidth(20),
                          ),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => model.tabChanged(index),
                              child: SizedBox(
                                width: sizeConfig.getPropWidth(
                                  index == 0 || index == 6 ? 82 : 76,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: sizeConfig.getPropWidth(28),
                                      width: sizeConfig.getPropWidth(28),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: model.currentTabIndex == index
                                              ? const Color(0xFF2128BD)
                                              : Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          sizeConfig.getPropWidth(8),
                                        ),
                                      ),
                                      child: FittedBox(
                                        child: SvgPicture.string(
                                          model.types[index].getSvg(),
                                          color: model.currentTabIndex == index
                                              ? const Color(0xFF2128BD)
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        model.types[index].getName(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    if (model.filterViewBy == "Brand")
                      SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                            sizeConfig.getPropWidth(16),
                            sizeConfig.getPropHeight(20),
                            sizeConfig.getPropWidth(16),
                            0,
                          ),
                          height: sizeConfig.getPropHeight(502),
                          child: PageView.builder(
                            controller: model.offerPageController,
                            itemCount: model.types.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, pageIndex) {
                              return RefreshIndicator(
                                onRefresh: model.refreshData,
                                child: homeModel.offersOfCategory[pageIndex]
                                            .brands.isEmpty &&
                                        !model.isBusy
                                    ? const Center(
                                        child: Text("No Offers found"),
                                      )
                                    : GridView.builder(
                                        itemCount: homeModel
                                                .offersOfCategory[pageIndex]
                                                .brands
                                                .isEmpty
                                            ? model.isBusy
                                                ? 8
                                                : 0
                                            : homeModel
                                                .offersOfCategory[pageIndex]
                                                .brands
                                                .length,
                                        padding: EdgeInsets.zero,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing:
                                              sizeConfig.getPropWidth(10),
                                          crossAxisSpacing:
                                              sizeConfig.getPropWidth(10),
                                          crossAxisCount: 2,
                                          childAspectRatio: 182 / 121,
                                        ),
                                        itemBuilder: (context, index) {
                                          if (model.isBusy) {
                                            return const ShimmerCard(
                                              size: Size(176.3, 117.2),
                                              borderRadius: 5,
                                            );
                                          }
                                          final brand = homeModel
                                              .offersOfCategory[pageIndex]
                                              .brands[index];
                                          return OpenContainer(
                                            closedBuilder: (context, onTap) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFFE7ECEE),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    sizeConfig.getPropHeight(5),
                                                  ),
                                                ),
                                                padding: EdgeInsets.only(
                                                  top: sizeConfig
                                                      .getPropHeight(15),
                                                  bottom: sizeConfig
                                                      .getPropHeight(16),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              'https://friday-images.s3.ap-south-1.amazonaws.com/${brand.brandId}.jpeg',
                                                          imageBuilder: (
                                                            context,
                                                            imageProvider,
                                                          ) =>
                                                              Container(
                                                            width: sizeConfig
                                                                .getPropWidth(
                                                              93,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image:
                                                                    imageProvider,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                          ),
                                                          placeholder: (
                                                            context,
                                                            url,
                                                          ) =>
                                                              const CircularProgressIndicator(),
                                                          errorWidget: (
                                                            context,
                                                            url,
                                                            error,
                                                          ) =>
                                                              const Icon(
                                                            Icons.error,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: sizeConfig
                                                          .getPropHeight(22),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            brand.brandName,
                                                            style: Theme.of(
                                                              context,
                                                            )
                                                                .textTheme
                                                                .bodyText2!
                                                                .copyWith(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                          ),
                                                          Text(
                                                            brand.totalOffers,
                                                            style: Theme.of(
                                                              context,
                                                            )
                                                                .textTheme
                                                                .bodyText2!
                                                                .copyWith(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      '${brand.expiringThisWeek} Offers expiring this week',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                            color: Colors.grey,
                                                            fontSize: 10,
                                                          ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                            openBuilder: (context, onTap) {
                                              return BrandOffersView(
                                                brandId: brand.brandId,
                                                brandName: brand.brandName,
                                              );
                                            },
                                            transitionDuration: const Duration(
                                              milliseconds: 750,
                                            ),
                                            closedElevation: 0.0,
                                            openElevation: 0.0,
                                            tappable: true,
                                            closedShape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            closedColor: Colors.transparent,
                                          );
                                        },
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                    if (model.filterViewBy == "Category")
                      ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container();
                        },
                        itemCount: 10,
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
