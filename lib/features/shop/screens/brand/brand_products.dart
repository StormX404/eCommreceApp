import 'package:e_commerce_app/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/appbar/appbar.dart';
import '../../../../core/widgets/brand/brand_card.dart';
import '../../../../core/widgets/products/sortable/sortable_products.dart';
import '../../../../core/widgets/shimmer/vertical_product_shimmer.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/brand_controller.dart';
import '../../models/brand_model.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return  Scaffold(
      appBar:  AAppBar(title: Text(brand.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            children: [
              /// Brand Detail
              ABrandCard(showBorder: true , brand: brand),
              const SizedBox(height: ASizes.spaceBtwSections),

              FutureBuilder(
                future: controller.getBrandProducts(brandId: brand.id),
                builder: (context , snapshot){

                  /// Handle Loader, No Record, Or Error Message
                  const loader = AVerticalProductShimmer();
                  final widget = ACloudHelperFunctions.checkMultiRecordState(snapshot: snapshot , loader:  loader);
                  if (widget != null) return widget;

                  final brandProducts = snapshot.data!;
                  return  ASortableProducts(products: brandProducts);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}