import 'package:e_commerce_app/navigation_menu.dart';
import 'package:e_commerce_app/utils/helpers/cloud_helper_functions.dart';
import 'package:e_commerce_app/utils/loaders/animation_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/widgets/appbar/appbar.dart';
import '../../../../core/widgets/icons/circular_icon.dart';
import '../../../../core/widgets/layouts/grid_layout.dart';
import '../../../../core/widgets/products/product_card/product_card_vertical.dart';
import '../../../../core/widgets/shimmer/vertical_product_shimmer.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/products/favourite_controller.dart';
import '../home/home_screen.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouriteController.instance;
    return Scaffold(
      appBar: AAppBar(
        title:
        Text('Wishlist', style: Theme
            .of(context)
            .textTheme
            .headlineMedium),
        /*actions: [
          ACircularIcon(
            icon: Iconsax.add,
            onPressed: () {
              Get.off(() => const NavigationMenu(), arguments: {'selectedIndex': 0});
            },
          ),
        ],*/
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Obx(() => FutureBuilder(
                future: controller.favoriteProducts(),
                builder: (context, snapshot) {
                  // Nothing Found Widget
                  final emptyWidget = AAnimationLoaderWidget(
                    text: 'Whoops! wish list is Empty...',
                    animation: AImages.pencilAnimation,
                    actionText: 'Let\'s add some',
                    onActionPressed: () {
                      Get.off(() => const NavigationMenu(), arguments: {'selectedIndex': 0});
                    }
                  );


                  const loader = AVerticalProductShimmer();
                  final widget = ACloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                    nothingFound: emptyWidget,
                  );
                  if (widget != null) return widget;

                  final products = snapshot.data!;
                  return AGridLayout(
                      itemCount: products.length,
                      itemBuilder: (_, index) =>
                          AProductCardVertical(
                            product: products[index],
                          ));
                }),
          ),
        ),
      ),
    );
  }
}
