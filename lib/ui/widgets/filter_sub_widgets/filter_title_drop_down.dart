import 'package:flutter/material.dart';
import 'package:fridayy_one/services/service_locator.dart';

class FilterTitleDropDown extends StatelessWidget {
  const FilterTitleDropDown({
    Key? key,
    required this.title,
    required this.selectedDropDownValue,
    required this.dropDownOptions,
    this.onDropDownUpdate,
  }) : super(key: key);
  final String title;
  final String? selectedDropDownValue;
  final List<String> dropDownOptions;
  final Function(String?)? onDropDownUpdate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: sizeConfig.getPropHeight(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                ),
          ),
          Container(
            width: sizeConfig.getPropWidth(147),
            height: sizeConfig.getPropHeight(40),
            padding: EdgeInsets.symmetric(
              horizontal: sizeConfig.getPropWidth(8),
            ),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              underline: const SizedBox(),
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              value: selectedDropDownValue,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 14,
                  ),
              borderRadius: BorderRadius.circular(sizeConfig.getPropWidth(8)),
              items: dropDownOptions.map((String value) {
                return DropdownMenuItem<String>(
                  alignment: Alignment.centerLeft,
                  value: value,
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 14,
                          color: value == selectedDropDownValue
                              ? const Color(0xFF2128BD)
                              : Colors.black,
                        ),
                  ),
                );
              }).toList(),
              onChanged: onDropDownUpdate,
            ),
          ),
        ],
      ),
    );
  }
}
