import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fridayy_one/business_logic/utils/extensions.dart';
import 'package:fridayy_one/business_logic/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_logic/view_models/HomeViewModels/home_screen_holder_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/HomeViewModels/spending_screen_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/base_view.dart';
import 'package:fridayy_one/ui/widgets/charts/src/doughnut_chart.dart';
import 'package:fridayy_one/ui/widgets/rounded_rectangular_button.dart';
import 'package:fridayy_one/ui/widgets/shimmer_card.dart';
import 'package:intl/intl.dart';

class SpendingScreen extends StatelessWidget {
  const SpendingScreen({Key? key, required this.homeModel}) : super(key: key);
  final HomeScreenHolderViewModel homeModel;

  String getDate(int expiry) {
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    return formatter.format(DateTime.fromMillisecondsSinceEpoch(expiry));
  }

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

  Widget buildSpending(SpendingScreenViewModel model) {
    return RefreshIndicator(
      onRefresh: model.getTransactionData,
      edgeOffset: 0.0,
      strokeWidth: 0.0,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      child: Container(
        height: sizeConfig.getPropHeight(600),
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
        alignment: Alignment.center,
        child: ListView.separated(
          itemCount: model.isBusy
              ? 7
              : model.data.spends.isEmpty
                  ? 1
                  : model.data.spends.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (model.isBusy) {
              return const ShimmerCard(
                size: Size(380, 72),
                borderRadius: 16.0,
              );
            } else if (model.data.spends.isEmpty) {
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
                child: Image.network(
                  'https://friday-images.s3.ap-south-1.amazonaws.com/${spend.brandId}.jpeg',
                  fit: BoxFit.contain,
                ),
              ),
              title: Text(
                spend.brandName,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 16,
                      color: Colors.black,
                    ),
              ),
              subtitle: Text(
                getDate(double.parse(spend.date).toInt()),
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

  Widget buildCategory(BuildContext context, SpendingScreenViewModel model) {
    return RefreshIndicator(
      onRefresh: model.getCategoryData,
      edgeOffset: 0.0,
      strokeWidth: 0.0,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      child: SizedBox(
        height: sizeConfig.getPropHeight(600),
        child: Column(
          children: [
            if (model.categoryData.isNotEmpty)
              SizedBox(
                height: sizeConfig.getPropHeight(161),
                child: model.isBusy
                    ? const ShimmerCard(
                        size: Size(380, 152),
                        borderRadius: 16,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: DoughnutChart(
                              size: 161,
                              data: model.categoryData,
                              isSemiDonut: false,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: List.generate(model.categoryData.length,
                                  (index) {
                                return Row(
                                  children: [
                                    Container(
                                      height: sizeConfig.getPropHeight(13),
                                      width: sizeConfig.getPropHeight(13),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: model
                                            .categoryData[index].categoryId
                                            .getColor(),
                                      ),
                                    ),
                                    Text(
                                      '  ${model.categoryData[index].categoryId.getName()} ${model.categoryData[index].percentage}%',
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
                alignment: model.spendCategoryData.distribution.isEmpty
                    ? Alignment.center
                    : Alignment.topCenter,
                child: ListView.separated(
                  itemCount: model.isBusy
                      ? 8
                      : model.spendCategoryData.distribution.isEmpty
                          ? 1
                          : model.spendCategoryData.distribution.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (model.isBusy) {
                      return const ShimmerCard(
                        size: Size(380, 72),
                        borderRadius: 16.0,
                      );
                    } else if (model.spendCategoryData.distribution.isEmpty) {
                      return const Center(
                        child: Text('No data found'),
                      );
                    }
                    final category =
                        model.spendCategoryData.distribution[index];
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
                        child: category.categoryId.getSvgIcon(),
                      ),
                      title: Text(
                        category.categoryId.getName(),
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
      edgeOffset: 0.0,
      strokeWidth: 0.0,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      child: Container(
        height: sizeConfig.getPropHeight(600),
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
        alignment: model.spendBrandData.brands.isEmpty
            ? Alignment.center
            : Alignment.topCenter,
        child: ListView.separated(
          itemCount: model.isBusy
              ? 7
              : model.spendBrandData.brands.isEmpty
                  ? 1
                  : model.spendBrandData.brands.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (model.isBusy) {
              return const ShimmerCard(
                size: Size(380, 72),
                borderRadius: 16.0,
              );
            } else if (model.spendBrandData.brands.isEmpty) {
              return const Center(
                child: Text('No data found'),
              );
            }
            final brand = model.spendBrandData.brands[index];
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
                child: Image.network(
                  'https://friday-images.s3.ap-south-1.amazonaws.com/${brand.brandId}.jpeg',
                  fit: BoxFit.contain,
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
                brand.categoryId!,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 14,
                      color: const Color(0xFF717E95),
                    ),
              ),
              trailing: Text(
                "${model.spendBrandData.brands.length} Spends",
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
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.months[
                              int.parse(model.dateFilter.substring(2)) - 1],
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 20, color: Colors.black),
                        ),
                        Text(
                          "Total Spent - ${model.data.currency} ${model.data.totalAmount}",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 16,
                                color: const Color(0xFF2128BD),
                              ),
                        ),
                      ],
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
