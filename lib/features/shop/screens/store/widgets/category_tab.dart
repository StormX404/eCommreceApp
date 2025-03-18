import 'package:e_commerce_app/features/shop/controllers/category_controller.dart';
import 'package:e_commerce_app/features/shop/models/category_model.dart';
import 'package:e_commerce_app/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce_app/features/shop/screens/store/widgets/category_brands.dart';
import 'package:e_commerce_app/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/widgets/layouts/grid_layout.dart';
import '../../../../../core/widgets/products/product_card/product_card_vertical.dart';
import '../../../../../core/widgets/shimmer/vertical_product_shimmer.dart';
import '../../../../../core/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';

class ACategoryTab extends StatelessWidget {
  const ACategoryTab({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            children: [
              // Brands
              CategoryBrands(category: category),
              const SizedBox(height: ASizes.spaceBtwItems),

              FutureBuilder(
                future: controller.getCategoryProducts(categoryId: category.id),
                builder: (context, snapshot) {
                  final response = ACloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: const AVerticalProductShimmer());
                  if (response != null) return response;

                  final products = snapshot.data!;

                  return Column(
                    children: [
                      ASectionHeading(
                        title: 'You might like',
                        onPressed: () => Get.to(AllProductsScreen(
                          title: category.name,
                          futureMethod: controller.getCategoryProducts(
                              categoryId: category.id),
                        )),
                      ),
                      const SizedBox(height: ASizes.spaceBtwItems),
                      AGridLayout(
                          itemCount: products.length,
                          itemBuilder: (_, index) =>
                              AProductCardVertical(product: products[index])),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
