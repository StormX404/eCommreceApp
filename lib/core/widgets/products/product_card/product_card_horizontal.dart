import 'package:e_commerce_app/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/products/product_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../images/custom_rounded_image.dart';
import '../../texts/brand_title_text_with_verified_icon.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title_text.dart';
import '../favourite_icon/favourite_icon.dart';

class AProductCardHorizontal extends StatelessWidget {
  const AProductCardHorizontal({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = AHelperFunctions.isDarkMode(context);

    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ASizes.productImageRadius),
        color: dark ? AColors.darkerGrey : AColors.softGrey,
      ),
      child: Row(
        children: [
          /// Thumbnail
          ARoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(ASizes.sm),
            backgroundColor: dark ? AColors.dark : AColors.light,
            child: Stack(
              children: [
                /// -- Thumbnail Image
                SizedBox(
                  height: 120,
                  width: 120,
                  child: ARoundedImage(
                    imageUrl: product.thumbnail,
                    isNetworkImage: true,
                  ),
                ),
                if (salePercentage != null)
                  Positioned(
                    top: 12,
                    child: ARoundedContainer(
                      radius: ASizes.sm,
                      backgroundColor: AColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: ASizes.sm, vertical: ASizes.xs),
                      child: Text(
                        '$salePercentage%',
                        style: Theme.of(context).textTheme.labelLarge!.apply(
                              color: AColors.black,
                            ),
                      ),
                    ),
                  ),

                /// -- Favorite Icon Button
                Positioned(
                  top: 0,
                  right: 0,
                  child: AFavouriteIcon(productId: product.id),
                ),
              ],
            ),
          ),

          /// Details
          SizedBox(
            width: 172,
            child: Padding(
              padding: const EdgeInsets.only(top: ASizes.sm, left: ASizes.sm),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AProductTitleText(
                        title: product.title,
                        smallSize: true,
                      ),
                      const SizedBox(height: ASizes.spaceBtwItems / 2),
                      ABrandTitleWithVerifiedIcon(title: product.brand!.name),
                    ],
                  ),
                  const Spacer(),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Pricing
                        Flexible(
                          child: Column(
                            children: [
                              if (product.productType == ProductType.single.toString() && product.salePrice > 0)
                              Padding(
                                padding: const EdgeInsets.only(left: ASizes.sm),
                                child: Text(
                                  product.price.toString(),
                                  style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: ASizes.sm),
                                  child: AProductPriceText(
                                      price: controller.getProductPrice(product))),
                            ],
                          ),
                        ),

                      /// Add to Cart Button
                      Container(
                        decoration: const BoxDecoration(
                          color: AColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(ASizes.cardRadiusMd),
                            bottomRight:
                                Radius.circular(ASizes.productImageRadius),
                          ),
                        ),
                        child: const SizedBox(
                          width: ASizes.iconLg * 1.2,
                          height: ASizes.iconLg * 1.2,
                          child: Center(
                            child: Icon(
                              Iconsax.add,
                              color: AColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
