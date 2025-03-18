import 'package:get/get.dart';

import '../../models/product_model.dart';
import '../../models/product_variation_model.dart';
import '../cart_controller.dart';
import 'image_controller.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  /// variables
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation = ProductVariationModel.empty().obs;

  void onAttributeSelected(ProductModel product, attributeName, attributeValue) {

    final selectedAttributes = Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariations = product.productVariations!.firstWhere(
          (variation) => _isSameAttributesValue(variation.attributesValues, selectedAttributes),
      orElse: () => ProductVariationModel.empty(),
    );

    /// Show the selected Variation Image as a Main Image
    if (selectedVariations.image.isNotEmpty) {
      ImageController.instance.selectedProductImage.value = selectedVariations.image;
    }

    /// Shon selected variation quantity already in the cart.
    if (selectedVariations.id.isNotEmpty) {
      final cartController = CartController.instance;
      cartController.productQuantityInCart.value = cartController
          .getVariationQuantityInCart(product.id, selectedVariations.id);
    }

    /// Assign Selected Variation
    selectedVariation.value = selectedVariations;

    /// Update selected product variation status
    getProductVariationStockStatus();
  }

  /// Check If selected attributes matche any variation attributes
  bool _isSameAttributesValue(Map<String, dynamic> variationAttributes, Map<String, dynamic> selectedAttributes) {
    {
      /// If selectedAttributes contains 3 attributes and current variation contains 2 then return.
      if (variationAttributes.length != selectedAttributes.length) return false;

      /// If any of the attributes is different then return. e. q. (Green, Large) x (Green, Snail)
      for (var key in variationAttributes.keys) {
        /// Attributes(Key): value which could be (Green. Small. Cotton) etc.
        if (variationAttributes[key] != selectedAttributes[key]) return false;
      }
      return true;
    }
  }

  /// check Attribute availability / Stock in variation
  Set<String?> getAttributesAvailabilityInVariation(
      List<ProductVariationModel> variations, String attributeName) {
    /// Pass the variations to check which are available and stock is not 0
    final availableVariationAttribute = variations
        .where((element) =>
    element.attributesValues[attributeName] != null &&
        element.attributesValues[attributeName]!.isNotEmpty &&
        element.stock > 0)
        .map((variations) => variations.attributesValues[attributeName])
        .toSet();

    return availableVariationAttribute ;
  }

  /// Check Product Variation Stock Status
  void getProductVariationStockStatus() {
    variationStockStatus.value =
    selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }

  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
        ? selectedVariation.value.salePrice
        : selectedVariation.value.price)
        .toString();
  }
}