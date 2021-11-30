import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fridayy_one/business_logic/models/spend_category_model.dart';
import 'package:fridayy_one/business_logic/models/spends_model.dart';
import 'package:fridayy_one/business_logic/utils/constants.dart';
import 'package:fridayy_one/business_logic/utils/enums.dart';
import 'package:fridayy_one/business_logic/utils/extensions.dart';
import 'package:fridayy_one/business_logic/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/home_screen_holder_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/spends/spending_screen_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/base_view.dart';
import 'package:fridayy_one/ui/widgets/cards/render_list.dart';
import 'package:fridayy_one/ui/widgets/charts/src/doughnut_chart.dart';
import 'package:fridayy_one/ui/widgets/rounded_rectangular_button.dart';
import 'package:fridayy_one/ui/widgets/shimmer_card.dart';

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
                      value: months[model.month - 1],
                      items: months.map((String value) {
                        return DropdownMenuItem<String>(
                          alignment: Alignment.centerLeft,
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        update(() {
                          model.month = months.indexOf('$value') + 1;
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
      child: RenderList<SpendsModel>(
        isBusy: model.loadingTransactions,
        items: homeModel.spendsTransactionData?.spends ?? [],
        type: ListType.spendTrans,
      ),
    );
  }

  Widget buildCategory(BuildContext context, SpendingScreenViewModel model) {
    // homeModel.categoryData.sort((a, b) => b.percentage.compareTo(a.percentage));
    return RefreshIndicator(
      onRefresh: model.getCategoryData,
      edgeOffset: 0.0,
      strokeWidth: 0.0,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      child: SizedBox(
        height: sizeConfig.getPropHeight(600),
        child: Column(
          children: [
            if (homeModel.categoryData.isNotEmpty)
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
                              data: homeModel.categoryData,
                              isSemiDonut: false,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: List.generate(
                                  homeModel.categoryData.length, (index) {
                                return Row(
                                  children: [
                                    Container(
                                      height: sizeConfig.getPropHeight(13),
                                      width: sizeConfig.getPropHeight(13),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: homeModel
                                            .categoryData[index].categoryId
                                            .getColor(),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          '${homeModel.categoryData[index].categoryId.getName()} ${homeModel.categoryData[index].percentage.toStringAsFixed(1)}%',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                fontSize: 12,
                                                color: Colors.black,
                                              ),
                                        ),
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
              child: RenderList<Distribution>(
                isBusy: model.loadingCategories,
                items: homeModel.spendCategoryData?.distribution ?? [],
                type: ListType.spendCategory,
                listItemAdditionalParams: {
                  'month':
                      months[int.parse(homeModel.dateFilter!.substring(2)) - 1],
                  'filter': homeModel.dateFilter,
                },
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
      child: RenderList<SpendsModel>(
        isBusy: model.loadingBrands,
        items: homeModel.spendBrandData?.brands ?? [],
        type: ListType.spendBrand,
        listItemAdditionalParams: {
          'month': months[int.parse(homeModel.dateFilter!.substring(2)) - 1],
          'filter': homeModel.dateFilter,
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SpendingScreenViewModel>(
      onModelReady: (model) => model.init(homeModel),
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
                Container(
                  height: sizeConfig.getPropHeight(105),
                  color: const Color(0xFFF9F9F9),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: sizeConfig.getPropWidth(50),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                months[int.parse(
                                      homeModel.dateFilter!.substring(2),
                                    ) -
                                    1],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                              ),
                              Text(
                                model.isBusy ? "" : model.totalSpendAmount,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontSize: 16,
                                      color: const Color(0xFF2128BD),
                                    ),
                              ),
                            ],
                          ),
                          const Spacer(),
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
                      ),
                      Expanded(
                        child: Row(
                          children: List.generate(
                            3,
                            (index) => Expanded(
                              child: InkWell(
                                onTap: () => model.changeIndex(index),
                                child: AnimatedContainer(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: model.pageIndex == index
                                        ? Colors.white
                                        : const Color(0xFFF9F9F9),
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 2,
                                        color:
                                            homeModel.spendingPageIndex != index
                                                ? Colors.white
                                                : const Color(0xFF2128BD),
                                      ),
                                    ),
                                  ),
                                  duration: const Duration(milliseconds: 500),
                                  child: Text(
                                    index == 0
                                        ? "Spending"
                                        : index == 1
                                            ? "Categories"
                                            : "Brands",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: model.controller,
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
