import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/features/shop/controllers/banner_controller.dart';
import 'package:e_commerce_app/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../core/widgets/images/custom_rounded_image.dart';
import '../../../../../core/widgets/shimmer/shimmer_effect.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class PromoSlider extends StatelessWidget {
  const PromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(
      () {
        if (controller.isLoading.value) return const AShimmerEffect(width: double.infinity, height: 150);

        if (controller.banners.isEmpty) {
          return const Center(child: Text('No Data Found!'));
        }  else{
          return Column(
            children: [
              SizedBox(
                child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 2.5,
                    viewportFraction: 1,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 6),
                    autoPlayCurve: Curves.elasticOut,
                    onPageChanged: (index, _) => controller.updatePageIndicator(index),
                  ),
                  items: controller.banners.map((banner) => ARoundedImage(
                    borderRadius: ASizes.borderRadiusLg,
                    imageUrl: banner.imageUrl,
                    isNetworkImage: true,
                    onPressed: () => Get.toNamed(banner.targetScreen),
                  ))
                      .toList(),
                ),
              ),
              const SizedBox(height: ASizes.spaceBtwItems + 5),
              Obx(
                    () => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < controller.banners.length; i++)
                      ACircularContainer(
                        width: 20,
                        height: 4,
                        margin: const EdgeInsets.only(right: 10),
                        backgroundColor: controller.carousalCurrentIndex.value == i
                            ? AColors.primary
                            : AColors.grey,
                      ),
                  ],
                ),
              ),
            ],
          );
        }

      }
    );
  }
}
