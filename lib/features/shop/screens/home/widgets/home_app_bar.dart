import 'dart:ui';

import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/widgets/appbar/appbar.dart';
import '../../../../../core/widgets/custom_shapes/containers/custom_search_container.dart';
import '../../../../../core/widgets/products/cart/cart_counter_icon.dart';
import '../../../../../core/widgets/shimmer/shimmer_effect.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../personalization/controllers/user_controller.dart';
import 'home_categoreis.dart';

class AHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const AHomeAppBar({super.key}) : preferredSize = const Size.fromHeight(170);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    final dark = AHelperFunctions.isDarkMode(context);
    return AppBar(
      backgroundColor: dark ? AColors.dark.withAlpha(200) :AColors.white.withAlpha(200) ,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(color: Colors.transparent),
        ),
      ),
      toolbarHeight: preferredSize.height,
      title: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ATexts.homeAppbarTitle,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                    ),
                    const SizedBox(height: ASizes.spaceBtwItems / 3),
                    Obx(() {
                      if (controller.profileLoading.value) {
                        return const AShimmerEffect(width: 80, height: 15);
                      } else {
                        return Text(
                          controller.user.value.fullName,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                        );
                      }
                    }),
                  ],
                ),
                const ACartCounterIcon(
                  iconColor: AColors.black,
                  counterBgColor: AColors.black,
                  counterTextColor: AColors.white,
                )
              ],
            ),
          ),
          const SizedBox(height: ASizes.spaceBtwItems),
          const ACustomSearchContainer(hintText: 'Search in Store' , padding: EdgeInsets.zero,),
          const SizedBox(height: ASizes.spaceBtwItems),
          const HomeCategories(),
        ],
      ),


      /*// Cart Counter Icon is not finished
      actions: const [
        ACartCounterIcon(
          iconColor: AColors.white,
          counterBgColor: AColors.black,
          counterTextColor: AColors.white,
        )
      ],*/
    );
  }
}
