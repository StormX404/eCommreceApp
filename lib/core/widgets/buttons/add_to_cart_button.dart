import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/cart_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';

class ProductCartAddToCartButton extends StatelessWidget {
  const ProductCartAddToCartButton({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return InkWell(
      onTap: () {
        // if the product gave variations then show the product details for variation selection
        // else add product to the cart
        if (product.productType == ProductType.single.toString()) {
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        } else {}
      },
      child: Obx(() {
          final productQuantityInCart =
          cartController.getProductQuantityInCart(product.id);

          return Container(
            decoration: BoxDecoration(
              color: productQuantityInCart > 0 ? AColors.primary : AColors.dark,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(ASizes.cardRadiusMd),
                bottomRight: Radius.circular(ASizes.productImageRadius),
              ),
            ),
            child: SizedBox(
              width: ASizes.iconLg * 1.2,
              height: ASizes.iconLg * 1.2,
              child: Center(
                  child: productQuantityInCart > 0
                      ? Text(
                    productQuantityInCart.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(color: AColors.white),
                  )
                      : const Icon(
                    Iconsax.add,
                    color: AColors.white,
                  )
              ),
            ),
          );
        },
      ),
    );
  }
}