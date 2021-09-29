import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fridayy_one/business_login/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_login/view_models/HomeViewModels/home_screen_holder_view_model.dart';
import 'package:fridayy_one/business_login/view_models/HomeViewModels/spending_screen_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/base_view.dart';
import 'package:fridayy_one/ui/widgets/doughnut_chart.dart';

class SpendingScreen extends StatelessWidget {
  const SpendingScreen({Key? key, required this.homeModel}) : super(key: key);
  final HomeScreenHolderViewModel homeModel;

  Widget buildSpending() {
    return Container(
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
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
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
              child: Text(
                "S",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 20),
              ),
            ),
            title: Text(
              'Settlement',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 16,
                    color: Colors.black,
                  ),
            ),
            subtitle: Text(
              '12 Mar 2021',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 14,
                    color: const Color(0xFF717E95),
                  ),
            ),
            trailing: Text(
              "+31,123",
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
    );
  }

  Widget buildCategory(BuildContext context, SpendingScreenViewModel model) {
    return SizedBox(
      height: sizeConfig.getPropHeight(510),
      child: Column(
        children: [
          SizedBox(
            height: sizeConfig.getPropHeight(161),
            width: sizeConfig.getPropWidth(325),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    children: List.generate(model.categoryData.length, (index) {
                      return SizedBox(
                        width: sizeConfig.getPropWidth(127),
                        child: Row(
                          children: [
                            Container(
                              height: sizeConfig.getPropHeight(13),
                              width: sizeConfig.getPropHeight(13),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: model.categoryData[index].color,
                              ),
                            ),
                            Text(
                              '${model.categoryData[index].x} ${model.categoryData[index].y}%',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                            )
                          ],
                        ),
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
                itemCount: model.categoryData.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
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
                        model.categoryData[index].icon!,
                      ),
                    ),
                    title: Text(
                      model.categoryData[index].x,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 16,
                            color: const Color(0xFF717E95),
                          ),
                    ),
                    subtitle: Text(
                      '₹ ${model.categoryData[index].spendAmount!}',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 14,
                            color: const Color(0xFF000000),
                          ),
                    ),
                    trailing: Text(
                      '${model.categoryData[index].spendTimes.toString()} Spends',
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
    );
  }

  Widget buildBrand(BuildContext context, SpendingScreenViewModel model) {
    return Container(
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
        itemCount: model.brandData.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
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
              child: Text(
                "S",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 20),
              ),
            ),
            title: Text(
              model.brandData[index].brandCategory,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 16,
                    color: Colors.black,
                  ),
            ),
            subtitle: Text(
              model.brandData[index].brandName,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 14,
                    color: const Color(0xFF717E95),
                  ),
            ),
            trailing: Text(
              "${model.brandData[index].brandSpendTimes} Spends",
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SpendingScreenViewModel>(
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
                      "September",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 20, color: Colors.black),
                    ),
                    actions: [
                      InkWell(
                        onTap: () {},
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
                      buildSpending(),
                      buildCategory(context, model),
                      buildBrand(context, model),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // child: NestedScrollView(
          //   headerSliverBuilder: (context, value) {
          //     return [
          //       SliverAppBar(
          //         leadingWidth: sizeConfig.getPropWidth(50),
          //         leading: SizedBox(
          //           width: sizeConfig.getPropWidth(50),
          //         ),
          //         pinned: true,
          //         titleSpacing: 0.0,
          //         automaticallyImplyLeading: false,
          //         backgroundColor: const Color(0xFFF9F9F9),
          //         title: Text(
          //           "September",
          //           style: Theme.of(context)
          //               .textTheme
          //               .bodyText2!
          //               .copyWith(fontSize: 20, color: Colors.black),
          //         ),
          //         actions: [
          //           InkWell(
          //             onTap: () {},
          //             child: SvgPicture.string(
          //               FridayySvg.calenderIcon,
          //             ),
          //           ),
          //           SizedBox(
          //             width: sizeConfig.getPropWidth(47),
          //           )
          //         ],
          //         bottom: TabBar(
          //           labelColor: const Color(0xFF2128BD),
          //           unselectedLabelColor: const Color(0xFF000000),
          //           indicatorColor: const Color(0xFF2128BD),
          //           indicatorWeight: 1.0,
          //           labelStyle: Theme.of(context)
          //               .textTheme
          //               .bodyText2!
          //               .copyWith(fontSize: 16),
          //           tabs: [
          //             const Tab(text: "Spending"),
          //             const Tab(text: "Categories"),
          //             const Tab(text: "Brands"),
          //           ],
          //         ),
          //       ),
          //     ];
          //   },
          //   body: Column(
          //     children: [
          //       TabBarView(
          //         physics: const NeverScrollableScrollPhysics(),
          //         children: [
          //           Container(
          //             height: sizeConfig.getPropHeight(510),
          //             margin: EdgeInsets.symmetric(
          //               horizontal: sizeConfig.getPropWidth(16),
          //               vertical: sizeConfig.getPropHeight(16),
          //             ),
          //             decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(
          //                   sizeConfig.getPropWidth(16),
          //                 ),
          //                 border: Border.all(color: const Color(0xFFE7ECEE))),
          //             child: ListView.separated(
          //               itemCount: 10,
          //               shrinkWrap: true,
          //               itemBuilder: (context, index) {
          //                 return ListTile(
          //                   leading: Container(
          //                     width: sizeConfig.getPropHeight(44),
          //                     height: sizeConfig.getPropHeight(44),
          //                     alignment: Alignment.center,
          //                     decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(
          //                         sizeConfig.getPropWidth(8),
          //                       ),
          //                       color: const Color(0xFFF9F9F9),
          //                     ),
          //                     child: Text(
          //                       "S",
          //                       style: Theme.of(context)
          //                           .textTheme
          //                           .bodyText2!
          //                           .copyWith(fontSize: 20),
          //                     ),
          //                   ),
          //                   title: Text(
          //                     'Settlement',
          //                     style: Theme.of(context)
          //                         .textTheme
          //                         .bodyText2!
          //                         .copyWith(fontSize: 16, color: Colors.black),
          //                   ),
          //                   subtitle: Text(
          //                     '12 Mar 2021',
          //                     style:
          //                         Theme.of(context).textTheme.bodyText2!.copyWith(
          //                               fontSize: 14,
          //                               color: const Color(0xFF717E95),
          //                             ),
          //                   ),
          //                   trailing: Text(
          //                     "+31,123",
          //                     style:
          //                         Theme.of(context).textTheme.bodyText2!.copyWith(
          //                               fontSize: 16,
          //                               color: const Color(0xFF19B832),
          //                             ),
          //                   ),
          //                 );
          //               },
          //               separatorBuilder: (BuildContext context, int index) {
          //                 return Padding(
          //                   padding: EdgeInsets.symmetric(
          //                       horizontal: sizeConfig.getPropWidth(20)),
          //                   child: const Divider(),
          //                 );
          //               },
          //             ),
          //           ),
          //           SizedBox(
          //             height: sizeConfig.getPropHeight(510),
          //             child: Column(
          //               children: [
          //                 SizedBox(
          //                   height: sizeConfig.getPropHeight(161),
          //                   width: sizeConfig.getPropWidth(325),
          //                   child: Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: [
          //                       Expanded(
          //                         child: DoughnutChart(
          //                           size: 161,
          //                           data: model.data,
          //                           onTap: () {},
          //                         ),
          //                       ),
          //                       Expanded(
          //                         child: Column(
          //                           mainAxisAlignment: MainAxisAlignment.center,
          //                           children:
          //                               List.generate(model.data.length, (index) {
          //                             return SizedBox(
          //                               width: sizeConfig.getPropWidth(127),
          //                               child: Row(
          //                                 children: [
          //                                   Container(
          //                                     height:
          //                                         sizeConfig.getPropHeight(13),
          //                                     width: sizeConfig.getPropHeight(13),
          //                                     decoration: BoxDecoration(
          //                                       shape: BoxShape.circle,
          //                                       color: model.data[index].color,
          //                                     ),
          //                                   ),
          //                                   Text(
          //                                     '${model.data[index].x} ${model.data[index].y}%',
          //                                     style: Theme.of(context)
          //                                         .textTheme
          //                                         .bodyText2!
          //                                         .copyWith(
          //                                             fontSize: 12,
          //                                             color: Colors.black),
          //                                   )
          //                                 ],
          //                               ),
          //                             );
          //                           }),
          //                         ),
          //                       )
          //                     ],
          //                   ),
          //                 ),
          //                 Expanded(
          //                   child: Container(
          //                     margin: EdgeInsets.symmetric(
          //                       horizontal: sizeConfig.getPropWidth(16),
          //                       vertical: sizeConfig.getPropHeight(16),
          //                     ),
          //                     decoration: BoxDecoration(
          //                         borderRadius: BorderRadius.circular(
          //                           sizeConfig.getPropWidth(16),
          //                         ),
          //                         border:
          //                             Border.all(color: const Color(0xFFE7ECEE))),
          //                     child: ListView.separated(
          //                       itemCount: model.data.length,
          //                       shrinkWrap: true,
          //                       itemBuilder: (context, index) {
          //                         return ListTile(
          //                           leading: Container(
          //                             width: sizeConfig.getPropHeight(44),
          //                             height: sizeConfig.getPropHeight(44),
          //                             alignment: Alignment.center,
          //                             decoration: BoxDecoration(
          //                               borderRadius: BorderRadius.circular(
          //                                 sizeConfig.getPropWidth(8),
          //                               ),
          //                               color: const Color(0xFFF9F9F9),
          //                             ),
          //                             child: SvgPicture.string(
          //                                 model.data[index].icon!),
          //                           ),
          //                           title: Text(
          //                             model.data[index].x,
          //                             style: Theme.of(context)
          //                                 .textTheme
          //                                 .bodyText2!
          //                                 .copyWith(
          //                                     fontSize: 16,
          //                                     color: const Color(0xFF717E95)),
          //                           ),
          //                           subtitle: Text(
          //                             '₹ ${model.data[index].spendAmount!}',
          //                             style: Theme.of(context)
          //                                 .textTheme
          //                                 .bodyText2!
          //                                 .copyWith(
          //                                   fontSize: 14,
          //                                   color: const Color(0xFF000000),
          //                                 ),
          //                           ),
          //                           trailing: Text(
          //                             '${model.data[index].spendTimes.toString()} Spends',
          //                             style: Theme.of(context)
          //                                 .textTheme
          //                                 .bodyText2!
          //                                 .copyWith(
          //                                   fontSize: 16,
          //                                   color: Colors.black,
          //                                 ),
          //                           ),
          //                         );
          //                       },
          //                       separatorBuilder:
          //                           (BuildContext context, int index) {
          //                         return Padding(
          //                           padding: EdgeInsets.symmetric(
          //                               horizontal: sizeConfig.getPropWidth(20)),
          //                           child: const Divider(),
          //                         );
          //                       },
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Container()
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        );
      },
    );
  }
}
