import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fridayy_one/business_logic/models/spends_model.dart';
import 'package:fridayy_one/business_logic/utils/enums.dart';
import 'package:fridayy_one/business_logic/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/spends/category_transactions_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/base_view.dart';
import 'package:fridayy_one/ui/widgets/cards/render_list.dart';

class CategoryTransactions extends StatelessWidget {
  const CategoryTransactions({
    Key? key,
    required this.categoryName,
    required this.month,
    required this.amountSpend,
    required this.categoryId,
    required this.filter,
  }) : super(key: key);

  final String categoryName;
  final String categoryId;
  final String month;
  final String filter;
  final double amountSpend;

  @override
  Widget build(BuildContext context) {
    return BaseView<CategoryTransactionsViewModel>(
      onModelReady: (model) => model.init(categoryId, filter),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: const Color(0xFFF9F9F9),
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
                size: 20,
              ),
              onPressed: () => navigationService.pop(),
            ),
            title: Text(
              categoryName,
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
                  onTap: model.gotoNotifications,
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
                height: sizeConfig.getPropHeight(70),
                color: const Color(0xFFF9F9F9),
                child: Row(
                  children: [
                    SizedBox(
                      width: sizeConfig.getPropWidth(50),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          month,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Total Spent - ${model.brandSpendData.currency} ${amountSpend.toString()}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 16,
                                color: const Color(0xFF2128BD),
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: model.getSpendingOnCategory,
                  edgeOffset: 0.0,
                  strokeWidth: 0.0,
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  child: RenderList<SpendsModel>(
                    isBusy: model.isBusy,
                    items: model.brandSpendData.spends,
                    type: ListType.spendTrans,
                    listItemAdditionalParams: {'brandId': categoryId},
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
