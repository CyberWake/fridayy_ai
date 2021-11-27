import 'package:flutter/material.dart';

class ToggleSwitchWithTitle extends StatelessWidget {
  const ToggleSwitchWithTitle({
    Key? key,
    required this.title,
    required this.onToggleChange,
    required this.toggleValue,
  }) : super(key: key);
  final String title;
  final bool toggleValue;
  final Function(bool?) onToggleChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(fontSize: 16, color: Colors.black),
        ),
        Switch(
          activeColor: const Color(0xFF2128BD),
          value: toggleValue,
          onChanged: onToggleChange,
        ),
      ],
    );
  }
}
