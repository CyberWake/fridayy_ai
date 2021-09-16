import 'package:flutter/material.dart';
import 'package:fridayy_one/services/service_locator.dart';

class Draw extends StatelessWidget {
  const Draw({Key? key, required this.squareSize, required this.painter})
      : super(key: key);
  final double squareSize;
  final CustomPainter painter;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
        sizeConfig.getPropWidth(squareSize),
        sizeConfig.getPropHeight(
          squareSize,
        ),
      ),
      painter: painter,
    );
  }
}
