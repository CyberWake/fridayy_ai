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
            minHeight: sizeConfig.getPropHeight(295),
          ),
          padding: EdgeInsets.fromLTRB(
            sizeConfig.getPropWidth(19),
            sizeConfig.getPropHeight(28),
            sizeConfig.getPropWidth(19),
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
                    onTap: navigationService.pop,
                    child: Container(
                      color: const Color(0xFF6200EE),
                      padding: EdgeInsets.symmetric(
                        horizontal: sizeConfig.getPropWidth(8),
                      ),
                      child: Text(
                        'Apply Filter',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  update(() {
                    model.filterExpiryType = 'Any';
                    model.filterRecommended = false;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(top: sizeConfig.getPropHeight(15)),
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
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF212121).withOpacity(0.08),
                      ),
                      child: DropdownButton<String>(
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
                width: sizeConfig.getPropWidth(326),
                padding: EdgeInsets.only(top: sizeConfig.getPropHeight(19)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(
                    3,
                    (index) => SizedBox(
                      width: sizeConfig.getPropWidth(
                        index == 0
                            ? 123
                            : index == 1
                                ? 128
                                : 74,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                          Text(
                            model.expiringTypes[index],
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: sizeConfig.getPropHeight(20),
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
              )
            ],
          ),
        );
      },
    );
  }

  Widget couponInfo() {
    return SizedBox(
      height: sizeConfig.getPropHeight(555),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: sizeConfig.getPropHeight(192),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                sizeConfig.getPropHeight(8),
              ),
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: sizeConfig.getPropHeight(9),
          ),
          Container(
            height: sizeConfig.getPropHeight(192),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                sizeConfig.getPropHeight(8),
              ),
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: sizeConfig.getPropHeight(17),
          ),
          CustomRoundRectButton(
            onTap: () => navigationService.pop(),
            size: const Size(335, 44),
            fillColor: const Color(0xFF2128BD),
            child: Text(
              'Claim this offer',
              style: Theme.of(navigationService.navigatorKey.currentContext!)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.white),
            ),
          ),
          SizedBox(
            height: sizeConfig.getPropHeight(56),
          ),
        ],
      ),
    );
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
          body: SingleChildScrollView(
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
                        padding:
                            EdgeInsets.only(left: sizeConfig.getPropHeight(8)),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE7ECEE)),
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
                SizedBox(
                  height: sizeConfig.getPropHeight(48),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: model.types.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => model.tabChanged(index),
                        child: SizedBox(
                          width: sizeConfig.getPropWidth(76),
                          child: Column(
                            children: [
                              Container(
                                height: sizeConfig.getPropWidth(28),
                                width: sizeConfig.getPropWidth(28),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: model.currentTabIndex == index
                                        ? Colors.blue
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
                                        ? Colors.blue
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
                      itemBuilder: (context, index) {
                        return GridView.builder(
                          itemCount: 8,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: sizeConfig.getPropWidth(16),
                            crossAxisSpacing: sizeConfig.getPropWidth(16),
                            crossAxisCount: 2,
                            childAspectRatio: 182 / 121,
                          ),
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFE7ECEE)),
                                borderRadius: BorderRadius.circular(
                                  sizeConfig.getPropHeight(5),
                                ),
                              ),
                              padding: EdgeInsets.only(
                                top: sizeConfig.getPropHeight(18),
                                bottom: sizeConfig.getPropHeight(16),
                              ),
                              child: InkWell(
                                onTap: () => model.useCoupon(couponInfo()),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              'https://i.pravatar.cc/${index + 1}00',
                                            ),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: sizeConfig.getPropHeight(18),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Company Name',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                          ),
                                          Text(
                                            'Value',
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
                                      '05 Offers expiring this week',
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
                            );
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
