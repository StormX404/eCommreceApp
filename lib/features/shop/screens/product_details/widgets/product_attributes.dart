import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/widgets/chips/choice_chip.dart';
import '../../../../../core/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../core/widgets/texts/product_price_text.dart';
import '../../../../../core/widgets/texts/product_title_text.dart';
import '../../../../../core/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/products/variation_controller.dart';

class AProductAttributes extends StatelessWidget {
  const AProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = AHelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());

    return Obx( () {
      return Column(
        children: [
          /// -- Selected Attribute Pricing & Description
          if (controller.selectedVariation.value.id.isNotEmpty)
            ARoundedContainer(
              padding: const EdgeInsets.all(ASizes.md),
              backgroundColor: dark ? AColors.darkerGrey : AColors.grey,
              child: Column(
                children: [
                  /// Title, Price, & Stock Status
                  Row(
                    children: [const ASectionHeading(title: 'Variation', showActionButton: false,),
                    const SizedBox(width: ASizes.spaceBtwItems),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const AProductTitleText(title: 'Price : ', smallSize: true),

                            /// Actual Price
                            if (controller.selectedVariation.value.salePrice > 0 )
                            Text(
                              '\$${controller.selectedVariation.value.price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(
                                      decoration: TextDecoration.lineThrough),
                            ),
                            const SizedBox(width: ASizes.spaceBtwItems),

                            /// Sale Price
                             AProductPriceText(price: controller.getVariationPrice()),
                          ],
                        ),

                        /// Stock
                        Row(
                          children: [const AProductTitleText(title: 'Stock : ', smallSize: true),
                            Text(controller.variationStockStatus.value, style: Theme.of(context).textTheme.titleMedium),
                          ],
                        )
                      ],
                    ),
                    ],
                  ),

                  /// Variation Description
                  AProductTitleText(
                    title: controller.selectedVariation.value.description ?? '',
                    smallSize: true,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          const SizedBox(height: ASizes.spaceBtwItems),

          /// -- Attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map((attribute) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ASectionHeading(
                            title: attribute.name ?? '', showActionButton: false),
                        const SizedBox(width: ASizes.spaceBtwItems / 2),
                        Obx(
                        () => Wrap(
                              spacing: 8,
                              children: attribute.values!.map((attributeValue) {
                                final isSelected = controller.selectedAttributes[attribute.name] == attributeValue;
                                final available = controller
                                    .getAttributesAvailabilityInVariation(product.productVariations!, attribute.name!)
                                    .contains(attributeValue);

                                return AChoiceChip(
                                    text: attributeValue,
                                    selected: isSelected,
                                    onSelected: available
                                        ? (selected) {
                                            if (selected && available) {
                                              controller.onAttributeSelected(product, attribute.name ?? '', attributeValue);
                                            }
                                          }
                                        : null);
                              }).toList()),
                        )
                      ],
                    ))
                .toList(),
          ),
        ],
      );
    }
    );
  }
}
