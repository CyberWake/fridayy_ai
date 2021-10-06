import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fridayy_one/business_login/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_login/view_models/HomeViewModels/home_screen_holder_view_model.dart';
import 'package:fridayy_one/business_login/view_models/HomeViewModels/spending_screen_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/base_view.dart';
import 'package:fridayy_one/ui/widgets/doughnut_chart.dart';
import 'package:fridayy_one/ui/widgets/rounded_rectangular_button.dart';

class SpendingScreen extends StatelessWidget {
  const SpendingScreen({Key? key, required this.homeModel}) : super(key: key);
  final HomeScreenHolderViewModel homeModel;

  Widget buildFilter(SpendingScreenViewModel model) {
    return StatefulBuilder(
      builder: (context, update) {
        return Container(
          constraints: BoxConstraints(
            minWidth: sizeConfig.getPropWidth(379),
            minHeight: sizeConfig.getPropHeight(233),
          ),
          padding: EdgeInsets.fromLTRB(
            sizeConfig.getPropWidth(28),
            sizeConfig.getPropHeight(21.82),
            sizeConfig.getPropWidth(28),
            0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(sizeConfig.getPropWidth(16)),
              topRight: Radius.circular(sizeConfig.getPropWidth(16)),
            ),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontSize: 20, color: Colors.black),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'For',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: 16, color: Colors.black),
                  ),
                  Container(
                    width: sizeConfig.getPropWidth(130),
                    height: sizeConfig.getPropHeight(40),
                    padding: EdgeInsets.symmetric(
                      horizontal: sizeConfig.getPropWidth(8),
                    ),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: const Color(0xFF212121).withOpacity(0.08),
                      borderRadius:
                          BorderRadius.circular(sizeConfig.getPropWidth(8)),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      borderRadius:
                          BorderRadius.circular(sizeConfig.getPropWidth(16)),
                      underline: const SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      value: model.months[model.month - 1],
                      items: model.months.map((String value) {
                        return DropdownMenuItem<String>(
                          alignment: Alignment.centerLeft,
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        update(() {
                          model.month = model.months.indexOf('$value') + 1;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: sizeConfig.getPropWidth(90),
                    height: sizeConfig.getPropHeight(40),
                    padding: EdgeInsets.symmetric(
                      horizontal: sizeConfig.getPropWidth(8),
                    ),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: const Color(0xFF212121).withOpacity(0.08),
                      borderRadius:
                          BorderRadius.circular(sizeConfig.getPropWidth(8)),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      borderRadius:
                          BorderRadius.circular(sizeConfig.getPropWidth(16)),
                      underline: const SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      value: model.year,
                      items: model.years.map((String value) {
                        return DropdownMenuItem<String>(
                          alignment: Alignment.center,
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        update(() {
                          model.year = value ?? DateTime.now().year.toString();
                          print(model.year);
                        });
                      },
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top: sizeConfig.getPropHeight(17),
                ),
                child: CustomRoundRectButton(
                  onTap: () {
                    navigationService.pop();
                    model.setDate();
                  },
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

  Widget getOfferImage(
    BuildContext context, {
    required String name,
  }) {
    for (int i = 0; i < homeModel.brandData.length; i++) {
      if (homeModel.brandData[i]['brandName'].toString() == name) {
        return Image.memory(
          base64.decode(
            homeModel.brandData[i]['brandImg'].toString().split(',').last,
          ),
          scale: 1.5,
        );
      }
    }
    return Image.asset('');
  }

  Widget buildSpending(SpendingScreenViewModel model) {
    return RefreshIndicator(
      onRefresh: model.getTransactionData,
      child: Container(
        height: sizeConfig.getPropHeight(510),
        margin: EdgeInsets.symmetric(
          horizontal: sizeConfig.getPropWidth(16),
          vertical: sizeConfig.getPropHeight(16),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            sizeConfig.getPropWidth(16),
          ),
          border: Border.all(color: const Color(0xFFE7ECEE)),
        ),
        child: model.isBusy
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemCount: model.data.count == 0 ? 1 : model.data.count,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (model.data.count == 0) {
                    return const Center(
                      child: Text('No data found'),
                    );
                  }
                  final spend = model.data.spends[index];
                  return ListTile(
                    leading: Container(
                      width: sizeConfig.getPropHeight(44),
                      height: sizeConfig.getPropHeight(44),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          sizeConfig.getPropWidth(8),
                        ),
                        color: const Color(0xFFF9F9F9),
                      ),
                      child: getOfferImage(context, name: spend.brandName),
                    ),
                    title: Text(
                      spend.brandName,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                    ),
                    subtitle: Text(
                      spend.date,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 14,
                            color: const Color(0xFF717E95),
                          ),
                    ),
                    trailing: Text(
                      "Rs. ${spend.amount}",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 16,
                            color: const Color(0xFF19B832),
                          ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: sizeConfig.getPropWidth(20),
                    ),
                    child: const Divider(),
                  );
                },
              ),
      ),
    );
  }

  String? getName(String id) {
    switch (id) {
      case 'FAD':
        return 'Food & Drinks';
      case 'MDCL':
        return 'Medical';
      case 'UTL':
        return 'Utilities';
      case 'TRVL':
        return 'Travel';
      case 'LUX':
        return 'Shopping';
      case 'FIN':
        return 'Finance';
      case 'OTH':
        return 'Others';
      case 'EAD':
        return 'Education & Dev';
    }
  }

  Color? getColor(String id) {
    switch (id) {
      case 'FAD':
        return const Color(0xFFF86F34);
      case 'MDCL':
        return const Color(0xFF2128BD);
      case 'UTL':
        return const Color(0xFF75CDD3);
      case 'TRVL':
        return const Color(0xFFFFB731);
      case 'LUX':
        return const Color(0xFF16331C);
      case 'FIN':
        return const Color(0xFF0A8677);
      case 'OTH':
        return const Color(0xFFC61C1C);
      case 'EAD':
        return const Color(0xFF14EDAA);
    }
  }

  String getCategoryIcon(String id) {
    switch (id) {
      case 'FAD':
        return FridayySvg.foodIcon;
      case 'MDCL':
        return FridayySvg.medicineIcon;
      case 'UTL':
        return FridayySvg.utilitiesIcon;
      case 'TRVL':
        return FridayySvg.travelIcon;
      case 'LUX':
        return FridayySvg.shoppingIcon;
      case 'FIN':
        return FridayySvg.financeIcon;
      case 'OTH':
        return FridayySvg.othersIcon;
      case 'EAD':
        return FridayySvg.educationIcon;
    }
    return "";
  }

  String getCategoryName(String id) {
    switch (id) {
      case 'FAD':
        return 'Food & Drinks';
      case 'MDCL':
        return 'Medical';
      case 'UTL':
        return 'Utilities';
      case 'TRVL':
        return 'Travel';
      case 'LUX':
        return 'Shopping';
      case 'FIN':
        return 'Finance';
      case 'OTH':
        return 'Others';
      case 'EAD':
        return 'Education & Development';
    }
    return "";
  }

  Widget buildCategory(BuildContext context, SpendingScreenViewModel model) {
    return RefreshIndicator(
      onRefresh: model.getCategoryData,
      child: SizedBox(
        height: sizeConfig.getPropHeight(510),
        child: Column(
          children: [
            SizedBox(
              height: sizeConfig.getPropHeight(161),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: DoughnutChart(
                      size: 161,
                      data: model.categoryData,
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children:
                          List.generate(model.categoryData.length, (index) {
                        return Row(
                          children: [
                            Container(
                              height: sizeConfig.getPropHeight(13),
                              width: sizeConfig.getPropHeight(13),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: getColor(
                                  model.categoryData[index].categoryId,
                                ),
                              ),
                            ),
                            Text(
                              '  ${getName(model.categoryData[index].categoryId)} ${model.categoryData[index].percentage}%',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                            )
                          ],
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: sizeConfig.getPropWidth(16),
                  vertical: sizeConfig.getPropHeight(16),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    sizeConfig.getPropWidth(16),
                  ),
                  border: Border.all(
                    color: const Color(0xFFE7ECEE),
                  ),
                ),
                child: ListView.separated(
                  itemCount: model.spendCategoryData.isEmpty
                      ? 1
                      : model.spendCategoryData.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (model.spendCategoryData.isEmpty) {
                      return const Center(
                        child: Text('No data found'),
                      );
                    }
                    final category = model.spendCategoryData[index];
                    return ListTile(
                      leading: Container(
                        width: sizeConfig.getPropHeight(44),
                        height: sizeConfig.getPropHeight(44),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            sizeConfig.getPropWidth(8),
                          ),
                          color: const Color(0xFFF9F9F9),
                        ),
                        child: SvgPicture.string(
                          getCategoryIcon(category.categoryId),
                        ),
                      ),
                      title: Text(
                        getCategoryName(category.categoryId),
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 16,
                              color: const Color(0xFF717E95),
                            ),
                      ),
                      subtitle: Text(
                        '₹ ${category.amount}',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 14,
                              color: const Color(0xFF000000),
                            ),
                      ),
                      trailing: Text(
                        '${category.count} Spends',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: sizeConfig.getPropWidth(20),
                      ),
                      child: const Divider(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBrand(BuildContext context, SpendingScreenViewModel model) {
    return RefreshIndicator(
      onRefresh: model.getBrandData,
      child: Container(
        height: sizeConfig.getPropHeight(510),
        margin: EdgeInsets.symmetric(
          horizontal: sizeConfig.getPropWidth(16),
          vertical: sizeConfig.getPropHeight(16),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            sizeConfig.getPropWidth(16),
          ),
          border: Border.all(color: const Color(0xFFE7ECEE)),
        ),
        child: ListView.separated(
          itemCount:
              model.spendBrandData.isEmpty ? 1 : model.spendBrandData.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (model.spendBrandData.isEmpty) {
              return const Center(
                child: Text('No data found'),
              );
            }
            final brand = model.spendBrandData[index];
            return ListTile(
              leading: Container(
                width: sizeConfig.getPropHeight(44),
                height: sizeConfig.getPropHeight(44),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    sizeConfig.getPropWidth(8),
                  ),
                  color: const Color(0xFFF9F9F9),
                ),
                child: getOfferImage(
                  context,
                  name: brand.brandName,
                ),
              ),
              title: Text(
                brand.brandName,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 16,
                      color: Colors.black,
                    ),
              ),
              subtitle: Text(
                getCategoryName(brand.spends[0].categoryId!),
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 14,
                      color: const Color(0xFF717E95),
                    ),
              ),
              trailing: Text(
                "${brand.count} Spends",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 16,
                      color: const Color(0xFF000000),
                    ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sizeConfig.getPropWidth(20),
              ),
              child: const Divider(),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SpendingScreenViewModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
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
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: sizeConfig.getPropHeight(105),
                  child: AppBar(
                    leadingWidth: sizeConfig.getPropWidth(50),
                    leading: SizedBox(
                      width: sizeConfig.getPropWidth(50),
                    ),
                    titleSpacing: 0.0,
                    toolbarHeight: sizeConfig.getPropHeight(105),
                    automaticallyImplyLeading: false,
                    backgroundColor: const Color(0xFFF9F9F9),
                    title: Text(
                      model
                          .months[int.parse(model.dateFilter.substring(2)) - 1],
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 20, color: Colors.black),
                    ),
                    actions: [
                      InkWell(
                        onTap: () =>
                            model.changeDateTimeFilter(buildFilter(model)),
                        child: SvgPicture.string(
                          FridayySvg.calenderIcon,
                        ),
                      ),
                      SizedBox(
                        width: sizeConfig.getPropWidth(47),
                      )
                    ],
                    bottom: TabBar(
                      labelColor: const Color(0xFF2128BD),
                      unselectedLabelColor: const Color(0xFF000000),
                      indicatorColor: const Color(0xFF2128BD),
                      indicatorWeight: 1.0,
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 16),
                      tabs: [
                        const Tab(text: "Spending"),
                        const Tab(text: "Categories"),
                        const Tab(text: "Brands"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      buildSpending(model),
                      buildCategory(context, model),
                      buildBrand(context, model),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
