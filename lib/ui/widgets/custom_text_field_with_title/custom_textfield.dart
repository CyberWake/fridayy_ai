import 'package:flutter/material.dart';
import 'package:fridayy_one/services/service_locator.dart';

class CustomTextFieldWithTitle extends StatelessWidget {
  const CustomTextFieldWithTitle({
    Key? key,
    this.controller,
    required this.title,
    this.prefix,
    required this.validator,
    this.hintText,
    this.enabled,
    this.initialText,
    this.style,
    this.filledColor = Colors.white,
    required this.keyboardType,
    required this.textInputAction,
  }) : super(key: key);
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String title;
  final String? prefix;
  final String? hintText;
  final String? initialText;
  final bool? enabled;
  final TextStyle? style;
  final Color? filledColor;
  final String? Function(String?) validator;

  static InputBorder borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      sizeConfig.getPropHeight(10),
    ),
    borderSide: const BorderSide(
      color: Color(0xFFE5E5E5),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
        ),
        SizedBox(
          height: sizeConfig.getPropHeight(5),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              sizeConfig.getPropHeight(10),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                spreadRadius: 0,
                blurRadius: 20,
                offset: const Offset(4, 10),
                color: const Color(0xFF000000).withOpacity(0.1),
              ),
            ],
          ),
          child: TextFormField(
            enabled: enabled ?? true,
            controller: controller,
            initialValue: initialText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            style: style ??
                TextStyle(
                  color: Colors.black,
                  letterSpacing: sizeConfig.getPropWidth(2),
                ),
            validator: (value) => validator(value),
            decoration: InputDecoration(
              focusedBorder: borderStyle,
              enabledBorder: borderStyle,
              disabledBorder: borderStyle,
              border: borderStyle,
              errorStyle: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: 12,
                    color: const Color(0xFFB00020),
                  ),
              prefixText: prefix,
              hintText: hintText,
              helperStyle: style,
              filled: true,
              helperMaxLines: 2,
              fillColor: filledColor,
            ),
          ),
        ),
      ],
    );
  }
}
