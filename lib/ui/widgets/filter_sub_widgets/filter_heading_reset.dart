import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fridayy_one/business_logic/utils/fridayy_svg.dart';
import 'package:fridayy_one/services/service_locator.dart';

class FilterHeadingAndReset extends StatelessWidget {
  const FilterHeadingAndReset({Key? key, this.onResetTap}) : super(key: key);
  final Function()? onResetTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Filters',
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(fontSize: 16, color: Colors.black),
        ),
        InkWell(
          onTap: onResetTap,
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
    );
  }
}
