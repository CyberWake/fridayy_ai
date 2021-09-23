import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fridayy_one/business_login/utils/fridayy_svg.dart';
import 'package:fridayy_one/services/service_locator.dart';

class USPTile extends StatelessWidget {
  const USPTile({Key? key, required this.uspName, required this.onTap})
      : super(key: key);
  final String uspName;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: sizeConfig.getPropHeight(20),
      ),
      height: sizeConfig.getPropHeight(25),
      width: sizeConfig.getPropWidth(411),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: sizeConfig.getPropWidth(16)),
            child: Text(
              uspName,
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Colors.black),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: sizeConfig.getPropWidth(45)),
            child: InkWell(
              onTap: onTap,
              child: SvgPicture.string(
                FridayySvg.arrowIcon,
              ),
            ),
          )
        ],
      ),
    );
  }
}
