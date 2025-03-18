import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/widgets/products/cart/add_remove_button.dart';
import '../../../../../core/widgets/products/cart/cart_item.dart';
import '../../../../../core/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/cart_controller.dart';

class ACartItems extends StatelessWidget {
  const ACartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(
          () {
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.cartItems.length,
          separatorBuilder: (context, index) =>
          const SizedBox(height: ASizes.spaceBtwSections),
          itemBuilder: (context, index) => Obx(
                () {
              final item = controller.cartItems[index];
              return Column(
                children: [
                  ACartItem(cartItem: item),
                  if (showAddRemoveButtons)
                    const SizedBox(height: ASizes.spaceBtwItems),
                  if (showAddRemoveButtons)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 70),
                            AProductQuantityWithAddRemoveButton(
                              quantity: item.quantity,
                              add: () => controller.addOneToCart(item),
                              remove: () => controller.removeOneToCart(item),
                            ),
                          ],
                        ),
                        AProductPriceText(
                            price:
                            (item.price * item.quantity).toStringAsFixed(1))
                      ],
                    )
                ],
              );
            },
          ),
        );
      },
    );
  }
}