import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../features/shop/screens/brand/brand_products.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../shimmer/shimmer_effect.dart';
import 'brand_card.dart';

class ABrandShowcase extends StatelessWidget {
  const ABrandShowcase({
    super.key,
    required this.images, required this.brand,
  });

  final BrandModel brand;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(brand: brand,)),
      child: ARoundedContainer(
        showBorder: true,
        borderColor: AColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(ASizes.md),
        margin: const EdgeInsets.only(bottom: ASizes.spaceBtwItems),
        child: Column(
          children: [
            /// Brand with Products Count
             ABrandCard(showBorder: false, brand: brand),
            const SizedBox(height: ASizes.spaceBtwItems),

            /// Brand Top 3 Product Images
            Row(
              children: images.map((image) => brandTopProductImageWidget(image, context)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    return Expanded(
      child: ARoundedContainer(
        height: 100,
        backgroundColor: AHelperFunctions.isDarkMode(context)
            ? AColors.darkerGrey
            : AColors.light,
        margin: const EdgeInsets.only(right: ASizes.sm),
        padding: const EdgeInsets.all(ASizes.md),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.contain,
          progressIndicatorBuilder: (context, url, progress) =>
          const AShimmerEffect(width: 100, height: 100),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}