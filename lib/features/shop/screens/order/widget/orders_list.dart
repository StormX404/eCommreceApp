import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../navigation_menu.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/loaders/animation_loader.dart';
import '../../../controllers/order_controller.dart';

class OrderListItems extends StatelessWidget {
  const OrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AHelperFunctions.isDarkMode(context);

    final controller = Get.put(OrderController());

    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (_, snapshot) {
        // nothing found widget
        final emptyWidget = AAnimationLoaderWidget(
          text: 'Whoops No Orders Yet!',
          actionText: 'Lets fill it',
          onActionPressed: () => Get.off(() => const NavigationMenu()),
          animation: AImages.docerAnimation,
        );

        // helper function handler loader no record or error message
        final response = ACloudHelperFunctions.checkMultiRecordState(
            snapshot: snapshot, nothingFound: emptyWidget);
        if (response != null) return response;

        final orders = snapshot.data!;

        return ListView.separated(
          shrinkWrap: true,
          itemCount: orders.length,
          separatorBuilder: (_, __) =>
          const SizedBox(height: ASizes.spaceBtwItems),
          itemBuilder: (_, index) {
            final order = orders[index];

            return ARoundedContainer(
              showBorder: true,
              backgroundColor: dark ? AColors.dark : AColors.light,
              padding: const EdgeInsets.all(ASizes.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // row 1
                  Row(
                    children: [
                      // icon
                      const Icon(Iconsax.ship),
                      const SizedBox(width: ASizes.spaceBtwItems / 2),

                      // status and date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.orderStatusText,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(
                                  color: AColors.primary,
                                  fontWeightDelta: 1),
                            ),
                            Text(
                              order.formattedOrderDate,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),

                      // icon
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Iconsax.arrow_right_34,
                          size: ASizes.iconSm,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: ASizes.spaceBtwItems),

                  // Bottom row
                  Row(
                    children: [
                      // Order NO
                      Expanded(
                        child: Row(
                          children: [
                            // icon
                            const Icon(Iconsax.tag),
                            const SizedBox(width: ASizes.spaceBtwItems / 2),

                            // status and date
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order',
                                    style:
                                    Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(
                                    order.id,
                                    style:
                                    Theme.of(context).textTheme.titleMedium,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // delivery date
                      Expanded(
                        child: Row(
                          children: [
                            // icon
                            const Icon(Iconsax.calendar),
                            const SizedBox(width: ASizes.spaceBtwItems / 2),

                            // status and date
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Shipping date',
                                    style:
                                    Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(
                                    order.formattedDeliveryDate,
                                    style:
                                    Theme.of(context).textTheme.titleMedium,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}