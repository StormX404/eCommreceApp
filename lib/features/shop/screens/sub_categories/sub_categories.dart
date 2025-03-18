import 'package:e_commerce_app/features/shop/screens/all_products/all_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/appbar/appbar.dart';
import '../../../../core/widgets/images/custom_rounded_image.dart';
import '../../../../core/widgets/products/product_card/product_card_horizontal.dart';
import '../../../../core/widgets/shimmer/horizontal_product_shimmer.dart';
import '../../../../core/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/category_controller.dart';
import '../../models/category_model.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;

    return Scaffold(
      appBar: AAppBar(
        title: Text(category.name),
        showBackArrow: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            children: [
              /// Banner
              const ARoundedImage(
                width: double.infinity,
                imageUrl: AImages.promoBanner1,
              ),
              const SizedBox(height: ASizes.spaceBtwSections),

              /// Sub Categories
              FutureBuilder(
                  future: controller.getSubCategories(category.id),
                  builder: (context, snapshot) {
                    /// Handle loader no record or error message
                    const loader = AHorizontalProductShimmer();
                    final widget = ACloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;

                    /// record found
                    final subCategories = snapshot.data!;

                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: subCategories.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          final subCategory = subCategories[index];

                          return FutureBuilder(
                              future: controller.getCategoryProducts(
                                  categoryId: subCategory.id),
                              builder: (context, snapshot) {
                                /// Handle loader no record or error message
                                final widget =
                                ACloudHelperFunctions.checkMultiRecordState(
                                    snapshot: snapshot, loader: loader);
                                if (widget != null) return widget;

                                /// record found
                                final products = snapshot.data!;

                                return Column(
                                  children: [
                                    /// Headings
                                    ASectionHeading(
                                      title: subCategory.name,
                                      onPressed: () => Get.to(
                                            () => AllProductsScreen(
                                          title: subCategory.name,
                                          futureMethod:
                                          controller.getCategoryProducts(
                                              categoryId: subCategory.id,
                                              limit: -1),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                        height: ASizes.spaceBtwItems / 2),

                                    SizedBox(
                                      height: 120,
                                      child: ListView.separated(
                                        itemCount: products.length,
                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          width: ASizes.spaceBtwItems,
                                        ),
                                        itemBuilder: (context, index) =>
                                            AProductCardHorizontal(
                                              product: products[index],
                                            ),
                                      ),
                                    ),

                                    const SizedBox(
                                        height: ASizes.spaceBtwItems),
                                  ],
                                );
                              });
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}