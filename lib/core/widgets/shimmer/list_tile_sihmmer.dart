import 'package:e_commerce_app/core/widgets/shimmer/shimmer_effect.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class AListTileShimmer extends StatelessWidget {
  const AListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AShimmerEffect(width: 50, height: 50, radius: 50),
            SizedBox(width: ASizes.spaceBtwItems),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AShimmerEffect(width: 100, height: 15),
                SizedBox(height: ASizes.spaceBtwItems / 2),
                AShimmerEffect(width: 80, height: 12)
              ],
            )
          ],
        )
      ],
    );
  }
}