import 'package:flutter/material.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/filter_sub_widgets/filter_heading_reset.dart';
import 'package:fridayy_one/ui/widgets/filter_sub_widgets/filter_title_drop_down.dart';
import 'package:fridayy_one/ui/widgets/rounded_rectangular_button.dart';

class CategoryPageFilter extends StatefulWidget {
  const CategoryPageFilter({
    Key? key,
    required this.offerType,
    this.onSaveFilter,
  }) : super(key: key);
  final String offerType;
  final Function(String)? onSaveFilter;

  @override
  State<CategoryPageFilter> createState() => _CategoryPageFilterState();
}

class _CategoryPageFilterState extends State<CategoryPageFilter> {
  late String offerType;
  @override
  void initState() {
    offerType = widget.offerType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeConfig.getPropHeight(194),
      width: sizeConfig.getPropWidth(379),
      padding: EdgeInsets.symmetric(
        horizontal: sizeConfig.getPropWidth(20),
        vertical: sizeConfig.getPropHeight(20),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          sizeConfig.getPropWidth(16),
        ),
      ),
      child: Column(
        children: [
          FilterHeadingAndReset(
            onResetTap: () {
              setState(() {
                offerType = 'Cashback';
              });
            },
          ),
          SizedBox(
            height: sizeConfig.getPropHeight(15),
          ),
          FilterTitleDropDown(
            title: 'Offer Type',
            dropDownOptions: [
              'Cashback',
              'Discount',
              'BOGO',
              'Promo',
              'Card Discount'
            ],
            selectedDropDownValue: offerType,
            onDropDownUpdate: (value) {
              setState(() {
                offerType = value ?? 'Cashback';
              });
            },
          ),
          SizedBox(
            height: sizeConfig.getPropHeight(8),
          ),
          CustomRoundRectButton(
            onTap: () {
              widget.onSaveFilter!(
                offerType,
              );
              navigationService.pop();
            },
            fillColor: Colors.white,
            child: Text(
              'Apply Filters',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}
