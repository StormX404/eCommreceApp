import 'package:e_commerce_app/features/shop/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/screens/cart/cart_screen.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ACartCounterIcon extends StatelessWidget {
  const ACartCounterIcon({
    super.key,
    this.iconColor,
    this.counterBgColor,
    this.counterTextColor,
  });
  final Color? iconColor, counterBgColor, counterTextColor;
  // final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // get an instance of cart controller
    final controller = Get.put(CartController());

    final dark = AHelperFunctions.isDarkMode(context);

    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => const CartScreen()),
          icon: const Icon(Iconsax.shopping_bag),
          color: iconColor,
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: counterBgColor ?? (dark ? AColors.white : AColors.black),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Obx(
                    () => Text(
                  controller.noOfCartItems.value.toString(),
                  style: Theme.of(context).textTheme.labelLarge!.apply(
                    color: counterTextColor ??
                        (dark ? AColors.white : AColors.black),
                    fontSizeFactor: 0.8,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}