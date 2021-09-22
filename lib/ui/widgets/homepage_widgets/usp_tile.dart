import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/utils/custom_painters/usp_arrow_icon.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/draw.dart';

class USPTile extends StatelessWidget {
  const USPTile({Key? key, required this.uspName, required this.onTap})
      : super(key: key);
  final String uspName;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              child: Draw(
                squareSize:
                    24, //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: ArrowIcon(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
