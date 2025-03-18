import 'package:e_commerce_app/features/shop/controllers/order_controller.dart';
import 'package:e_commerce_app/features/shop/screens/checkout/widget/billing_address_section.dart';
import 'package:e_commerce_app/features/shop/screens/checkout/widget/billing_amount_section.dart';
import 'package:e_commerce_app/features/shop/screens/checkout/widget/billing_payment_section.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/appbar/appbar.dart';
import '../../../../core/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../core/widgets/products/cart/coupon_widget.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/helpers/pricing_calculator.dart';
import '../../controllers/cart_controller.dart';
import '../cart/widget/cart_items.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount = APricingCalculator.calculateTotalPrice(subTotal, 'EG');
    final dark = AHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AAppBar(
        showBackArrow: true,
        title: Text('Checkout',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            children: [
              /// -- Items in Cart
              const ACartItems(showAddRemoveButtons: false),
              const SizedBox(height: ASizes.spaceBtwSections),

              /// -- Coupon TextField
              const ACouponCode(),
              const SizedBox(height: ASizes.spaceBtwSections),

              /// -- Billing Section
              ARoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(ASizes.md),
                backgroundColor: dark ? AColors.black : AColors.white,
                child: const Column(
                  children: [
                    /// Pricing
                    BillingAmountSection(),
                    SizedBox(height: ASizes.spaceBtwItems),

                    /// Divider
                    Divider(),
                    SizedBox(height: ASizes.spaceBtwItems),

                    /// Payment Methods
                    BillingPaymentSection(),
                    SizedBox(height: ASizes.spaceBtwItems),

                    /// Address
                    BillingAddressSection(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),


      /// Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(ASizes.defaultSpace),
        child: ElevatedButton(
            onPressed: subTotal > 0
                ? () => orderController.processOrder(totalAmount)
                : () => ALoaders.warningSnackBar(
                      title: 'Empty Cart',
                      message: 'Add items in the cart in order to proceed.',
                    ),
            child: Text('Checkout \$$totalAmount')),
      ),
    );
  }
}
