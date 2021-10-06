import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fridayy_one/business_login/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_login/view_models/HomeViewModels/home_screen_holder_view_model.dart';
import 'package:fridayy_one/business_login/view_models/HomeViewModels/offer_screen_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/base_view.dart';
import 'package:fridayy_one/ui/widgets/rounded_rectangular_button.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({Key? key, required this.homeModel}) : super(key: key);
  final HomeScreenHolderViewModel homeModel;

  Widget filterSheet(OfferScreenViewModel model) {
    return StatefulBuilder(
      builder: (context, update) {
        return Container(
          constraints: BoxConstraints(
            minWidth: sizeConfig.getPropWidth(379),
            minHeight: sizeConfig.getPropHeight(394),
          ),
          padding: EdgeInsets.fromLTRB(
            sizeConfig.getPropWidth(15),
            sizeConfig.getPropHeight(28),
            sizeConfig.getPropWidth(15),
            0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filters',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 16, color: Colors.black),
                  ),
                  InkWell(
                    onTap: () {
                      update(() {
                        model.filterExpiryType = 'Any';
                        model.filterRecommended = false;
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          'Clear All',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 16, color: Colors.grey),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: sizeConfig.getPropWidth(4),
                          ),
                          child: SvgPicture.string(FridayySvg.deleteIcon),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: sizeConfig.getPropHeight(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'View By',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 16, color: Colors.black),
                    ),
                    Container(
                      width: sizeConfig.getPropWidth(147),
                      height: sizeConfig.getPropHeight(40),
                      padding: EdgeInsets.symmetric(
                        horizontal: sizeConfig.getPropWidth(8),
                      ),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: const Color(0xFF212121).withOpacity(0.08),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        value: model.filterViewBy,
                        items:
                            <String>['Brand', 'Category'].map((String value) {
                          return DropdownMenuItem<String>(
                            alignment: Alignment.centerLeft,
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          update(() {
                            model.filterViewBy = value ?? "Brand";
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: sizeConfig.getPropHeight(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 16, color: Colors.black),
                    ),
                    Container(
                      width: sizeConfig.getPropWidth(147),
                      height: sizeConfig.getPropHeight(40),
                      padding: EdgeInsets.symmetric(
                        horizontal: sizeConfig.getPropWidth(8),
                      ),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: const Color(0xFF212121).withOpacity(0.08),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        value: model.filterDiscountType,
                        items: <String>['High to Low', 'Low to High']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          update(() {
                            model.filterDiscountType = value ?? "High to Low";
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: sizeConfig.getPropHeight(15)),
                child: Text(
                  'Expiring',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 16, color: Colors.black),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: sizeConfig.getPropHeight(19)),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Expanded(
                      flex: index == 2 ? 1 : 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio<String>(
                            fillColor: MaterialStateProperty.all(
                              const Color(0xFF6200EE),
                            ),
                            groupValue: model.filterExpiryType,
                            value: model.expiringTypes[index],
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onChanged: (value) {
                              update(() {
                                model.filterExpiryType = value ?? "";
                              });
                            },
                          ),
                          Flexible(
                            child: Text(
                              model.expiringTypes[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: sizeConfig.getPropHeight(25),
                margin: EdgeInsets.only(top: sizeConfig.getPropHeight(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recommended Coupons',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                    ),
                    Switch(
                      value: model.filterRecommended,
                      activeColor: const Color(0xFF6200EE),
                      onChanged: (value) {
                        update(() {
                          model.filterRecommended = value;
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: sizeConfig.getPropHeight(17),
                ),
                child: CustomRoundRectButton(
                  onTap: model.updateFilter,
                  fillColor: Colors.white,
                  child: Text(
                    'Apply Filter',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  ImageProvider getOfferImage(
    BuildContext context, {
    required String name,
  }) {
    for (int i = 0; i < homeModel.brandData.length; i++) {
      if (homeModel.brandData[i]['brandName'].toString() == name) {
        return MemoryImage(
          base64.decode(
            homeModel.brandData[i]['brandImg'].toString().split(',').last,
          ),
          scale: 1.5,
        );
      }
    }
    return const AssetImage('');
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<OfferScreenViewModel>(
      onModelReady: (model) => model.init(),
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
                            onTap: () => model.useFilter(filterSheet(model)),
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
                        height: sizeConfig.getPropHeight(52),
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
                                width: sizeConfig
                                    .getPropWidth(index == 0 ? 80 : 76),
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
                                          model.types[index]["image"] ?? "",
                                          color: model.currentTabIndex == index
                                              ? const Color(0xFF2128BD)
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      model.types[index]["title"] ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(fontSize: 12),
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
                          height: sizeConfig.getPropHeight(515),
                          child: PageView.builder(
                            controller: model.offerPageController,
                            itemCount: model.types.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, pageIndex) {
                              return RefreshIndicator(
                                onRefresh: model.refreshData,
                                child: GridView.builder(
                                  itemCount: model
                                          .categoryBrands[pageIndex].isEmpty
                                      ? model.isBusy
                                          ? 0
                                          : 1
                                      : model.categoryBrands[pageIndex].length,
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
                                    if (model.categoryBrands[pageIndex]
                                            .isEmpty &&
                                        !model.isBusy) {
                                      return const Center(
                                        child: Text("No Offers found"),
                                      );
                                    }
                                    final brand =
                                        model.categoryBrands[pageIndex][index];
                                    return Material(
                                      borderRadius: BorderRadius.circular(
                                        sizeConfig.getPropHeight(5),
                                      ),
                                      child: InkWell(
                                        onTap: () => model.gotoBrandOffers(
                                          homeModel.brandData,
                                          index,
                                          pageIndex,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xFFE7ECEE),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              sizeConfig.getPropHeight(5),
                                            ),
                                          ),
                                          padding: EdgeInsets.only(
                                            top: sizeConfig.getPropHeight(15),
                                            bottom:
                                                sizeConfig.getPropHeight(16),
                                          ),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: getOfferImage(
                                                        context,
                                                        name: brand.brandName,
                                                      ),
                                                      fit: BoxFit.none,
                                                      scale: 4,
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      brand.brandName,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                          ),
                                                    ),
                                                    Text(
                                                      brand.brandCouponCount
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                          ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                '${brand.brandCouponCount} Offers expiring this week',
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
                                        ),
                                      ),
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
              if (model.isBusy && model.offersOfCategory[0].isNotEmpty)
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.2),
                  child: const Center(child: CircularProgressIndicator()),
                )
            ],
          ),
        );
      },
    );
  }
}
