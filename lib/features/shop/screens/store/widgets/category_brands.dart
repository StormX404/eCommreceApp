import 'package:e_commerce_app/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/brand/brand_show_case.dart';
import '../../../../../core/widgets/shimmer/boxs_shimmer.dart';
import '../../../../../core/widgets/shimmer/list_tile_sihmmer.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/brand_controller.dart';
import '../../../models/category_model.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
        future: controller.getBrandForCategory(category.id),
        builder: (context, snapshot) {
          /// Handle Loader, No Record, OR Error Yesscge
          const loader = Column(
            children: [
              AListTileShimmer(),
              SizedBox(height: ASizes.spaceBtwItems),
              ABoxesShimmer(),
              SizedBox(height: ASizes.spaceBtwItems),
            ],
          );

          final widget = ACloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, loader: loader);
          if (widget != null) return widget;

          final brands = snapshot.data!;

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: brands.length,
            itemBuilder: (_, index) {
              final brand = brands[index];
              return FutureBuilder(
                  future: controller.getBrandProducts(brandId: brand.id, limit: 3),
                  builder: (context, snapshot) {
                    final widget = ACloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;

                    final products = snapshot.data!;

                    return ABrandShowcase(images: products.map((e) => e.thumbnail).toList(), brand: brand,);
                  });
            },
          );
        });
  }
}