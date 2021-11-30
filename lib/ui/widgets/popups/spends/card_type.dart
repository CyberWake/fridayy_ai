import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fridayy_one/business_logic/utils/extensions.dart';
import 'package:fridayy_one/services/service_locator.dart';

class CardTypePopUp extends StatelessWidget {
  const CardTypePopUp({Key? key, required this.onTap}) : super(key: key);
  final Function(String) onTap;

  static List<String> categories = [
    'UPI',
    'NETBANKING',
    'CREDIT CARD',
    'DEBIT CARD',
  ];

  Widget buildItems({
    required String label,
    required Function(String) onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () => onTap(label),
        child: Padding(
          padding: EdgeInsets.only(
            left: sizeConfig.getPropWidth(12),
          ),
          child: Row(
            children: [
              Container(
                height: sizeConfig.getPropWidth(44),
                width: sizeConfig.getPropWidth(44),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border:
                      Border.all(width: 0.5, color: const Color(0xFF2128BD)),
                ),
                child: SvgPicture.string(
                  label.getSvg(),
                  height: 36,
                  width: 36,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: sizeConfig.getPropWidth(28),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  label.getName(),
                  style:
                      Theme.of(navigationService.navigatorKey.currentContext!)
                          .textTheme
                          .caption!
                          .copyWith(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(top: sizeConfig.getPropHeight(41)),
          height: sizeConfig.getPropHeight(62),
          width: sizeConfig.getPropWidth(379),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              sizeConfig.getPropWidth(16),
            ),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: Text(
            'Choose Category',
            style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 16),
          ),
        ),
        SizedBox(
          height: sizeConfig.getPropHeight(16),
        ),
        Container(
          height: sizeConfig.getPropHeight(336),
          width: sizeConfig.getPropWidth(379),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              sizeConfig.getPropWidth(16),
            ),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: Column(
            children: [
              buildItems(
                label: categories[0],
                onTap: onTap,
              ),
              const Divider(),
              buildItems(
                label: categories[1],
                onTap: onTap,
              ),
              const Divider(),
              buildItems(
                label: categories[2],
                onTap: onTap,
              ),
              const Divider(),
              buildItems(
                label: categories[3],
                onTap: onTap,
              ),
            ],
          ),
        ),
        SizedBox(
          height: sizeConfig.getPropHeight(41),
        )
      ],
    );
  }
}
