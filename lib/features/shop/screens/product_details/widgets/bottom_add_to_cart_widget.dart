import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/widgets/icons/circular_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/cart_controller.dart';
import '../../../models/product_model.dart';

class ABottomAddToCart extends StatelessWidget {
  const ABottomAddToCart({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = AHelperFunctions.isDarkMode(context);
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: ASizes.defaultSpace, vertical: ASizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? AColors.darkerGrey : AColors.light,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(ASizes.cardRadiusLg),
          topLeft: Radius.circular(ASizes.cardRadiusLg),
        ),
      ),
      child: Obx(
            () {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ACircularIcon(
                    icon: Iconsax.minus,
                    backgroundColor: AColors.darkGrey,
                    width: 40,
                    height: 40,
                    color: AColors.white,
                    onPressed: () => controller.productQuantityInCart.value < 1
                        ? null
                        : controller.productQuantityInCart.value -= 1,
                  ),
                  const SizedBox(width: ASizes.defaultSpace),
                  Text(controller.productQuantityInCart.value.toString(),
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(width: ASizes.defaultSpace),
                  ACircularIcon(
                    icon: Iconsax.add,
                    backgroundColor: AColors.black,
                    width: 40,
                    height: 40,
                    color: AColors.white,
                    onPressed: () =>
                    controller.productQuantityInCart.value += 1,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: controller.productQuantityInCart.value < 1
                    ? null
                    : () => controller.addToCart(product),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(ASizes.md),
                    backgroundColor: AColors.black,
                    side: const BorderSide(color: AColors.black)),
                child: const Text('Add to Cart'),
              )
            ],
          );
        },
      ),
    );
  }
}