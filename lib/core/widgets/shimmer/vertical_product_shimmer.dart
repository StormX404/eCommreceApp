import 'package:e_commerce_app/core/widgets/shimmer/shimmer_effect.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';
import '../layouts/grid_layout.dart';

class AVerticalProductShimmer extends StatelessWidget {
  const AVerticalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return AGridLayout(
      itemCount: itemCount,
      itemBuilder: (p0, p1) => const SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AShimmerEffect(width: 180, height: 180),
            SizedBox(height: ASizes.spaceBtwItems),
            AShimmerEffect(width: 160, height: 15),
            SizedBox(height: ASizes.spaceBtwItems / 2),
            AShimmerEffect(width: 110, height: 15),
          ],
        ),
      ),
    );
  }
}