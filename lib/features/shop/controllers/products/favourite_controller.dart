import 'dart:convert';

import 'package:e_commerce_app/data/repos/product/product_repository.dart';
import 'package:get/get.dart';

import '../../../../utils/local_storage/storage_utility.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/product_model.dart';

class FavouriteController extends GetxController {
  static FavouriteController get instance => Get.find();

  // variables
  final favourites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavourite();
  }

  void initFavourite() {
    final json = ALocalStorage.instance().readData('favourites');
    if (json != null) {
      final storageFavourites = jsonDecode(json) as Map<String, dynamic>;
      favourites.assignAll(storageFavourites.map(
            (key, value) => MapEntry(key, value as bool),
      ));
    }
  }

  bool isFavourite(String productId) {
    return favourites[productId] ?? false;
  }

  void toggleFavouriteProducts(String productId) {
    if (!favourites.containsKey(productId)) {
      favourites[productId] = true;
      saveFavouritesToStorage();
      ALoaders.customToast(message: 'Product has been added to the Wishlist.');
    } else {
      ALocalStorage.instance().removeData(productId);
      favourites.remove(productId);
      saveFavouritesToStorage();
      favourites.refresh();
      ALoaders.customToast(
          message: 'Product has been removed from the Wishlist.');
    }
  }

  void saveFavouritesToStorage() {
    final encodeFavourites = json.encode(favourites);
    ALocalStorage.instance().saveData('favourites', encodeFavourites);
  }

  Future<List<ProductModel>> favoriteProducts() async {
    return await ProductRepository.instance
        .getFavouriteProduct(favourites.keys.toList());
  }
}