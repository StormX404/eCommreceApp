import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../core/widgets/images/custom_circular_image.dart';
import '../../../../../core/widgets/texts/brand_title_text_with_verified_icon.dart';
import '../../../../../core/widgets/texts/product_price_text.dart';
import '../../../../../core/widgets/texts/product_title_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/products/product_controller.dart';
import '../../../models/product_model.dart';

class AProductMetaData extends StatelessWidget {
  const AProductMetaData({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(product.price , product.salePrice);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            /// -- Sale Tag
            ARoundedContainer(
              radius: ASizes.sm,
              backgroundColor: AColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: ASizes.sm, vertical: ASizes.xs),
              child: Text(
                '$salePercentage%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: AColors.black),
              ),
            ),
            const SizedBox(width: ASizes.spaceBtwItems),

            /// -- Price
            if (product.productType == ProductType.single.toString() && product.salePrice > 0)
            Text(
              '\$${product.price}',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(decoration: TextDecoration.lineThrough),
            ),
            if (product.productType == ProductType.single.toString() && product.salePrice > 0)
            const SizedBox(width: ASizes.spaceBtwItems),
             AProductPriceText(price: controller.getProductPrice(product), isLarge: true),
          ],
        ),
        const SizedBox(height: ASizes.spaceBtwItems / 1.5),

        /// Title
        AProductTitleText(title: product.title),
        const SizedBox(height: ASizes.spaceBtwItems / 1.5),

        /// Stock Status
        Row(
          children: [
            const AProductTitleText(title: 'Status'),
            const SizedBox(width: ASizes.spaceBtwItems),
            Text(controller.getProductStockStatus(product.stock), style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: ASizes.spaceBtwItems / 1.5),

        /// Brand
        Row(
          children: [
            ACircularImage(
              image: product.brand != null ? product.brand!.image : '',
              width: 32,
              height: 32,
              isNetworkImage: true,
              overlayColor: darkMode ? AColors.white : AColors.black,
            ),
             ABrandTitleWithVerifiedIcon(
              title: product.brand != null ? product.brand!.name : '',
              brandTextSize: TextSizes.medium,
            ),
          ],
        ),
      ],
    );
  }
}