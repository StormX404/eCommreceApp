import 'package:e_commerce_app/features/shop/controllers/category_controller.dart';
import 'package:e_commerce_app/features/shop/screens/store/widgets/category_tab.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/appbar/appbar.dart';
import '../../../../core/widgets/appbar/tabbar.dart';
import '../../../../core/widgets/brand/brand_card.dart';
import '../../../../core/widgets/custom_shapes/containers/custom_search_container.dart';
import '../../../../core/widgets/layouts/grid_layout.dart';
import '../../../../core/widgets/products/cart/cart_counter_icon.dart';
import '../../../../core/widgets/shimmer/brand_shimmer.dart';
import '../../../../core/widgets/texts/section_heading.dart';
import '../../controllers/brand_controller.dart';
import '../brand/all_brands_screen.dart';
import '../brand/brand_products.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;
    final dark = AHelperFunctions.isDarkMode(context);

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: const [
            ACartCounterIcon(
              iconColor: AColors.black,
              counterBgColor: AColors.black,
              counterTextColor: AColors.white,
            )
          ],
        ),
        body: NestedScrollView(
          // -- Header
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  backgroundColor: dark ? AColors.black : AColors.white,
                  expandedHeight: 440,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(ASizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        // -- Search Bar
                        const SizedBox(height: ASizes.spaceBtwItems),
                        const ACustomSearchContainer(
                          hintText: 'Search in Store',
                          showBackground: false,
                          padding: EdgeInsets.zero,
                        ),
                        const SizedBox(height: ASizes.spaceBtwItems),

                        // -- Featured Brands
                        ASectionHeading(
                          title: 'Featured Brands',
                          onPressed: () =>
                              Get.to(() => const AllBrandsScreen()),
                        ),
                        const SizedBox(height: ASizes.spaceBtwItems / 1.5),

                        // -- Brands Grid
                        Obx(
                          () {
                            if (brandController.isLoading.value) {
                              return const ABrandShimmer();
                            }

                            if (brandController.featureBrand.isEmpty) {
                              return Center(
                                  child: Text('No Data Found!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .apply(color: Colors.white)));
                            }

                            return AGridLayout(
                              itemCount: brandController.featureBrand.length,
                              mainAxisExtent: 80,
                              itemBuilder: (_, index) {
                                final brand =
                                    brandController.featureBrand[index];
                                return ABrandCard(
                                  showBorder: true,
                                  brand: brand,
                                  onTap: () => Get.to(
                                    () => BrandProducts(brand: brand,),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  bottom: ATabBar(
                      tabs: categories
                          .map((category) => Tab(child: Text(category.name)))
                          .toList())),
            ];
          },
          body: TabBarView(
              children: categories
                  .map((category) => ACategoryTab(category: category))
                  .toList()),
        ),
      ),
    );
  }
}
