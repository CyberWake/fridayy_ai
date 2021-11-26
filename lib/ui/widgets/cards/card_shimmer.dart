import 'package:flutter/material.dart';
import 'package:fridayy_one/ui/widgets/shimmer_card.dart';

class ListShimmerCard extends StatelessWidget {
  const ListShimmerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ShimmerCard(
      size: Size(380, 72),
      borderRadius: 16.0,
    );
  }
}
