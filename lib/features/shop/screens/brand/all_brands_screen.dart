import 'package:e_commerce_app/features/shop/controllers/brand_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/appbar/appbar.dart';
import '../../../../core/widgets/brand/brand_card.dart';
import '../../../../core/widgets/layouts/grid_layout.dart';
import '../../../../core/widgets/shimmer/brand_shimmer.dart';
import '../../../../core/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import 'brand_products.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;

    return Scaffold(
      appBar: const AAppBar(title: Text('Brand'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            children: [

              /// Heading
              const ASectionHeading(title: 'Brands', showActionButton: false),
              const SizedBox(height: ASizes.spaceBtwItems),

              /// Brands
              Obx(() {
                if (controller.isLoading.value) return const ABrandShimmer();

                if (controller.allBrands.isEmpty) {
                  return Center(
                      child: Text('No Data Found!',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(color: Colors.white)));
                }
                return AGridLayout(
                    itemCount: controller.allBrands.length,
                    mainAxisExtent: 80,
                    itemBuilder: (context, index) {
                      final brand = controller.allBrands[index];
                      return ABrandCard(showBorder: true,
                        brand: brand,
                        onTap: () => Get.to(() =>  BrandProducts(brand: brand,)),
                      );
                    }
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
