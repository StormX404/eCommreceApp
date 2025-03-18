import 'package:e_commerce_app/features/shop/screens/cart/widget/cart_items.dart';
import 'package:e_commerce_app/utils/loaders/animation_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/appbar/appbar.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/cart_controller.dart';
import '../checkout/checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: AAppBar(
          showBackArrow: true,
          title:
              Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
      body: Obx(
        () {
          final emptyAnimationWidget = AAnimationLoaderWidget(
            showAction: true,
            text: 'Whoops! Cart Is EMPTY',
            animation: AImages.cartAnimation,
            actionText: 'Let\'s fill it',
            onActionPressed: () => Get.back(),
          );

          return controller.cartItems.isEmpty
              ? emptyAnimationWidget
              : const SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(ASizes.defaultSpace),
                    child: SingleChildScrollView(child: ACartItems()),
                  ),
                );
        },
      ),
      bottomNavigationBar: controller.cartItems.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(ASizes.defaultSpace),
              child: ElevatedButton(
                onPressed: () => Get.to(() => const CheckoutScreen()),
                child: Obx(
                  () {
                    return Text(
                        'Checkout \$${controller.totalCartPrice.value}');
                  },
                ),
              ),
            )
          : null,
    );
  }
}
