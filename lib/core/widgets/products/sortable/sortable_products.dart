import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/shop/controllers/all_product_contrroller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../dropdown/custom_dropdown.dart';
import '../../layouts/grid_layout.dart';
import '../product_card/product_card_vertical.dart';

class ASortableProducts extends StatelessWidget {
  const ASortableProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    controller.assignProducts(products);
    return Column(
      children: [
        DropdownWithContextMenu(sortController: controller),
        const SizedBox(height: ASizes.spaceBtwSections),
        Obx(() {
          return AGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (_, index) =>
                AProductCardVertical(product: controller.products[index]),
          );
        })
      ],
    );
  }
}