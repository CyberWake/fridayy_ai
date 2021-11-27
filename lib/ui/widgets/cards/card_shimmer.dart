import 'package:flutter/material.dart';
import 'package:fridayy_one/ui/widgets/shimmer_card.dart';

class ListShimmerCard extends StatelessWidget {
  const ListShimmerCard({Key? key, this.height, this.width}) : super(key: key);
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return ShimmerCard(
      size: Size(width ?? 380, height ?? 72),
      borderRadius: 4.0,
    );
  }
}
