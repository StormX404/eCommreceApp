import 'package:e_commerce_app/core/widgets/shimmer/shimmer_effect.dart';
import 'package:flutter/material.dart';

import '../layouts/grid_layout.dart';

class ABrandShimmer extends StatelessWidget {
  const ABrandShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return AGridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (p0, p1) => const AShimmerEffect(width: 300, height: 80),
    );
  }
}