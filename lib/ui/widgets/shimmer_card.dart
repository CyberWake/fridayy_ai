import 'package:flutter/material.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({
    Key? key,
    required this.size,
    this.marginTop,
    required this.borderRadius,
    this.isCenter = true,
    this.isCircle = false,
  }) : super(key: key);
  final Size size;
  final double? marginTop;
  final double borderRadius;
  final bool isCenter;
  final bool isCircle;

  Widget card() {
    return Container(
      height: sizeConfig.getPropHeight(size.height),
      width: sizeConfig.getPropWidth(size.width),
      margin: EdgeInsets.only(
        top: sizeConfig.getPropHeight(marginTop ?? 0.0),
      ),
      decoration: isCircle
          ? BoxDecoration(
              color: Colors.white,
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            )
          : BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                sizeConfig.getPropWidth(borderRadius),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey,
      child: isCenter
          ? Center(
              child: card(),
            )
          : card(),
    );
  }
}
