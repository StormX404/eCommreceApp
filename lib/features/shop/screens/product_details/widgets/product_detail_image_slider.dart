import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/widgets/appbar/appbar.dart';
import '../../../../../core/widgets/custom_shapes/curved_edges/curved_edge_widget.dart';
import '../../../../../core/widgets/images/custom_rounded_image.dart';
import '../../../../../core/widgets/products/favourite_icon/favourite_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/products/image_controller.dart';
import '../../../models/product_model.dart';

class AProductImageSlider extends StatelessWidget {
  const AProductImageSlider({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = AHelperFunctions.isDarkMode(context);

    final controller = Get.put(ImageController());
    final images = controller.getAllProductImages(product);

    return ACurvedEdgesWidget(
      child: Container(
        color: dark ? AColors.darkerGrey : AColors.light,
        child: Stack(
          children: [
            /// -- Main Large Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(ASizes.productImageRadius * 2),
                child: Center(
                  child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargeImage(context, image),
                      child: CachedNetworkImage(
                          imageUrl: image,
                          progressIndicatorBuilder: (_, __, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                  color: AColors.primary)),
                    );
                  }),
                ),
              ),
            ),

            /// -- Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: ASizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: ASizes.spaceBtwItems),
                  itemBuilder: (_, index) => Obx( (){
                    final imageSelected = controller.selectedProductImage.value == images[index];
                    return ARoundedImage(
                      width: 80,
                      isNetworkImage: true,
                      imageUrl: images[index],
                      backgroundColor: dark ? AColors.dark : AColors.white,
                      padding: const EdgeInsets.all(ASizes.sm),
                      border: Border.all(color: imageSelected ? AColors.primary : Colors.transparent),
                      onPressed: () => controller.selectedProductImage.value = images[index],
                    );
                  },
                  ),
                ),
              ),
            ),

            /// -- Appbar Icons
             AAppBar(
              showBackArrow: true,
              actions: [
               AFavouriteIcon(productId: product.id,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
