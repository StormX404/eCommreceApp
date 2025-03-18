import 'package:e_commerce_app/data/repos/orders/order_repositry.dart';
import 'package:e_commerce_app/features/shop/controllers/cart_controller.dart';
import 'package:e_commerce_app/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/success_screen/success_screen.dart';
import '../../authentication/data/repo/authentication_repository.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../personalization/controllers/address_controller.dart';
import '../models/order_model.dart';
import 'checkout_controller.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  // variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  /// Fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  /// Add methods for order processing
  void processOrder(double totalAmount) async {
    try {
      AFullScreenLoader.openLoadingDialog(
          'Processing your order...', AImages.pencilAnimation);

      // Get user Id
      final userId = AuthenticationRepository.instance.authUser?.uid;

      if (userId!.isEmpty) return;

      // Add Details
      final order = OrderModel(
        id: UniqueKey().toString(),
        status: OrderStatus.processing,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      );

      // Save the order to Firestone
      await orderRepository.saveOrder(order, userId);

      // Unpdate the cart status
      cartController.clearCart();

      Get.off(
            () => SuccessScreen(
          image: AImages.orderCompletedAnimation,
          isImage: false,
          title: 'Payment Success!',
          subtitle: 'Your item will be shipped soon!',
          onPressed: () => Get.offAll(() => const NavigationMenu()),
        ),
      );
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}