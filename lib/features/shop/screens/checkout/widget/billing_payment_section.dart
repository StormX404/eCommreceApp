import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../core/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/checkout_controller.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    final dark = AHelperFunctions.isDarkMode(context);

    return Column(
      children: [
        ASectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        const SizedBox(height: ASizes.spaceBtwItems / 2),
        Row(
          children: [
            ARoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? AColors.light : AColors.white,
              padding: const EdgeInsets.all(ASizes.sm),
              child: Image(
                image: AssetImage(controller.selectedPaymentMethod.value.image),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: ASizes.spaceBtwItems / 2),
            Text(controller.selectedPaymentMethod.value.name, style: Theme.of(context).textTheme.bodyLarge),
          ],
        )
      ],
    );
  }
}