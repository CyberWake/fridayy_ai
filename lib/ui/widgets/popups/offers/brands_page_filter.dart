import 'package:flutter/material.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/filter_sub_widgets/expiring_toggle.dart';
import 'package:fridayy_one/ui/widgets/filter_sub_widgets/filter_heading_reset.dart';
import 'package:fridayy_one/ui/widgets/filter_sub_widgets/filter_title_drop_down.dart';
import 'package:fridayy_one/ui/widgets/rounded_rectangular_button.dart';

class BrandsPageFilter extends StatefulWidget {
  const BrandsPageFilter({
    Key? key,
    required this.offerType,
    required this.expiring,
    this.onSaveFilter,
  }) : super(key: key);
  final String? offerType;
  final bool? expiring;
  final Function(String?, bool?)? onSaveFilter;
  @override
  _BrandsPageFilterState createState() => _BrandsPageFilterState();
}

class _BrandsPageFilterState extends State<BrandsPageFilter> {
  late String? offerType;
  late bool? expiring;
  @override
  void initState() {
    offerType = widget.offerType;
    expiring = widget.expiring;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeConfig.getPropHeight(257),
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
                offerType = null;
                expiring = null;
              });
            },
          ),
          SizedBox(
            height: sizeConfig.getPropHeight(15),
          ),
          FilterTitleDropDown(
            title: 'Offer Type',
            dropDownOptions: ['Cashback', 'Discount', 'Reward'],
            selectedDropDownValue: offerType,
            onDropDownUpdate: (value) {
              setState(() {
                offerType = value;
              });
            },
          ),
          // FilterTitleDropDown(
          //   title: 'Discount',
          //   dropDownOptions: [
          //     'Card',
          //     'Link',
          //     'UPI',
          //     'Cash Discount',
          //     'Wallet',
          //   ],
          //   selectedDropDownValue: availThrough,
          //   onDropDownUpdate: (value) {
          //     setState(() {
          //       availThrough = value;
          //     });
          //   },
          // ),
          ToggleSwitchWithTitle(
            title: 'Expiring',
            onToggleChange: (value) {
              setState(() {
                expiring = value ?? false;
              });
            },
            toggleValue: expiring ?? false,
          ),
          SizedBox(
            height: sizeConfig.getPropHeight(8),
          ),
          CustomRoundRectButton(
            onTap: () {
              widget.onSaveFilter!(
                offerType,
                expiring,
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
