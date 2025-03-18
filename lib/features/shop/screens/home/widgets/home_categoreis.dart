import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../../../core/widgets/shimmer/category_shimmer.dart';
import '../../../controllers/category_controller.dart';
import '../../sub_categories/sub_categories.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Obx(() {
      if (categoryController.isLoading.value ) return const ACategoryShimmer();

      if (categoryController.featuredCategories.isEmpty) {
        return Center(
          child: Text(
            'No Data Found!',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: Colors.grey),
          ),
        );
      }

      return SizedBox(
        height: 30,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: categoryController.featuredCategories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final category = categoryController.featuredCategories[index];
              return AVerticalImageText(
                title: category.name,
                textColor: Colors.grey,
                onTap: () => Get.to(() => SubCategoriesScreen(category: category)),
              );
            }),
      );
    });
  }
}
