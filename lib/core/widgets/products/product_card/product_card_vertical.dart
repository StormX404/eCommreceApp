import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/enums.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/shop/controllers/products/product_controller.dart';
import '../../../../features/shop/screens/product_details/product_detail_screen.dart';
import '../../../styles/shadows.dart';
import '../../buttons/add_to_cart_button.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../images/custom_rounded_image.dart';
import '../../texts/brand_title_text_with_verified_icon.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title_text.dart';
import '../favourite_icon/favourite_icon.dart';

class AProductCardVertical extends StatelessWidget {
  const AProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = AHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(
            product: product,
          )),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(ASizes.productImageRadius),
          color: dark ? AColors.darkerGrey : AColors.white,
        ),
        child: Column(
          children: [
            ARoundedContainer(
              height: 180,
              width: 180,
              padding: const EdgeInsets.all(ASizes.sm),
              backgroundColor: dark ? AColors.dark : AColors.light,
              child: Stack(
                children: [
                  Center(
                    child: ARoundedImage(
                      imageUrl: product.thumbnail,
                      applyImageRadius: true,
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
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: AColors.black),
                      ),
                    ),
                  ),

                  //Favourite Icon Button
                   Positioned(
                    top: 0,
                    right: 0,
                    child: AFavouriteIcon(productId: product.id),
                  ),
                ],
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwItems / 2),

            /// Details
            Padding(
              padding: const EdgeInsets.only(left: ASizes.sm),
              // wrap with sized box because of make the column full width
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AProductTitleText(title: product.title, smallSize: true),
                    const SizedBox(height: ASizes.spaceBtwItems / 2),
                    ABrandTitleWithVerifiedIcon(title: product.brand!.name)
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (product.productType == ProductType.single.toString() &&
                    product.salePrice > 0)
                  Padding(
                    padding: const EdgeInsets.only(left: ASizes.sm),
                    child: Text(
                      product.price.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .apply(decoration: TextDecoration.lineThrough),
                    ),
                  ),

                // Price
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: ASizes.sm),
                    child: AProductPriceText(
                        price: controller.getProductPrice(product)),
                  ),
                ),

                // Add to Cart Button
                ProductCartAddToCartButton (product: product)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
