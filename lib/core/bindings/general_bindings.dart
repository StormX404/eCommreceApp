import 'package:get/get.dart';

import '../../features/personalization/controllers/address_controller.dart';
import '../../features/shop/controllers/checkout_controller.dart';
import '../../features/shop/controllers/products/favourite_controller.dart';
import '../../features/shop/controllers/products/variation_controller.dart';
import '../../utils/helpers/network_manager.dart';


class GeneralBindings extends Bindings {

  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(AddressController());
    Get.put(CheckoutController());

  }
}