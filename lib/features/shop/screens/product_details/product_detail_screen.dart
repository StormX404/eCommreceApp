import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:e_commerce_app/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:e_commerce_app/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:e_commerce_app/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:e_commerce_app/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/widgets/texts/section_heading.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../product_review/product_review_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar:  ABottomAddToCart(product: product,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // - Product Image Slider
            AProductImageSlider(product: product),

            // - Product Details
            Padding(
              padding: const EdgeInsets.only(
                right: ASizes.defaultSpace,
                left: ASizes.defaultSpace,
                bottom: ASizes.defaultSpace,
              ),
              child: Column(
                children: [
                  /// -- Rating & Share Button
                  const RatingAndShare(),

                  /// -- Price, Title, Stock, & Brand
                  AProductMetaData(product: product),
                  const SizedBox(height: ASizes.spaceBtwItems / 2),

                  //..Attributes
                  if (product.productType == ProductType.variable.toString())
                    AProductAttributes(product: product),
                  if (product.productType == ProductType.variable.toString())
                    const SizedBox(height: ASizes.spaceBtwSections),

                  /// -- Checkout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Checkout'),
                    ),
                  ),
                  const SizedBox(height: ASizes.spaceBtwSections),

                  /// -- Description
                  const ASectionHeading(
                      title: 'Description', showActionButton: false),
                  const SizedBox(height: ASizes.spaceBtwSections),
                   ReadMoreText(
                    product.description! ?? '',
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Less',
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  /// -- Reviews
                  const Divider(),
                  const SizedBox(height: ASizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ASectionHeading(
                          title: 'Reviews(199)', showActionButton: false),
                      IconButton(
                        icon: const Icon(Iconsax.arrow_right_3, size: 18),
                        onPressed: () => Get.to(() => const ProductReviewScreen()),
                      ),
                    ],
                  ),
                  const SizedBox(height: ASizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}