import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/utils/enums.dart';
import 'package:fridayy_one/business_logic/utils/extensions.dart';
import 'package:fridayy_one/services/service_locator.dart';

class CustomGenderSelector extends StatelessWidget {
  const CustomGenderSelector({
    Key? key,
    required this.selected,
    required this.updateGender,
  }) : super(key: key);
  final Gender? selected;
  final Function(Gender) updateGender;

  static const List<Gender> genders = [
    Gender.male,
    Gender.female,
    Gender.others
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Gender',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
        ),
        SizedBox(
          height: sizeConfig.getPropHeight(5),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            3,
            (index) => Padding(
              padding: EdgeInsets.only(
                right: sizeConfig.getPropWidth(12),
              ),
              child: InkWell(
                onTap: () => updateGender(genders[index]),
                borderRadius: BorderRadius.circular(
                  sizeConfig.getPropHeight(10),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: sizeConfig.getPropHeight(13),
                    horizontal: sizeConfig.getPropWidth(16),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      sizeConfig.getPropHeight(10),
                    ),
                    color: Colors.white,
                    border: Border.all(
                      color: selected == genders[index]
                          ? const Color(0xFF2128BD)
                          : const Color(0xFFE5E5E5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: const Offset(4, 10),
                        color: const Color(0xFF000000).withOpacity(0.1),
                      ),
                    ],
                  ),
                  child: Text(
                    genders[index].string(),
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: selected == genders[index]
                              ? const Color(0xFF2128BD)
                              : const Color(0xFFABABAB),
                        ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
