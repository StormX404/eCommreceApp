import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/shop/controllers/banner_controller.dart';
import 'package:e_commerce_app/features/shop/screens/home/widgets/home_app_bar.dart';
import 'package:e_commerce_app/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/layouts/grid_layout.dart';
import '../../../../core/widgets/products/product_card/product_card_vertical.dart';
import '../../../../core/widgets/shimmer/vertical_product_shimmer.dart';
import '../../../../core/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/products/product_controller.dart';
import '../all_products/all_products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    final bannerController = Get.put(BannerController());

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: const AHomeAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchAllFeaturedProducts();
          await bannerController.fetchBanners();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(ASizes.defaultSpace),
            child: Column(
              children: [
                const SizedBox(height: ASizes.space225),
                const PromoSlider(),
                const SizedBox(height: ASizes.spaceBtwItems),

                ASectionHeading(
                  title: 'Popular Products',
                  onPressed: () => Get.to(() => AllProductsScreen(
                    title: 'Popular Products',
                    query: FirebaseFirestore.instance.collection('Products').where('IsFeatured', isEqualTo: true),
                    futureMethod: controller.fetchAllFeaturedProducts(),
                  )),
                ),
                const SizedBox(height: ASizes.spaceBtwItems),

                Obx(() {
                  if (controller.isLoading.value) {
                    return const AVerticalProductShimmer();
                  }

                  if (controller.featuredProducts.isEmpty) {
                    return Center(
                      child: Text(
                        'No Data Found!',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }

                  return AGridLayout(
                    itemCount: controller.featuredProducts.length,
                    itemBuilder: (_, index) => AProductCardVertical(
                      product: controller.featuredProducts[index],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
