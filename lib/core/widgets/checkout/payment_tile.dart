import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/shop/controllers/checkout_controller.dart';
import '../../../features/shop/models/payment_method_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';

class APaymentTile extends StatelessWidget {
  const APaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController();

    return Material(
      color: Colors.transparent,
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        onTap: () {
          controller.selectedPaymentMethod.value = paymentMethod;
          Get.back();
        },
        leading: ARoundedContainer(
          width: 60,
          height: 60,
          backgroundColor: AHelperFunctions.isDarkMode(context)
              ? AColors.light
              : AColors.white,
          padding: const EdgeInsets.all(ASizes.sm),
          child: Image(image: AssetImage(paymentMethod.image), fit: BoxFit.contain),
        ),
        title: Text(paymentMethod.name),
        trailing: const Icon(Iconsax.arrow_right_34),
      ),
    );
  }
}