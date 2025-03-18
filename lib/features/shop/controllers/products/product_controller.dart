import 'package:get/get.dart';

import '../../../../data/repos/product/product_repository.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  // variables
  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  /// fetch featured products
  Future<void> fetchFeaturedProducts() async {
    try {
      // show loader while loading categories
      isLoading.value = true;

      // fetch categories from data source
      final products = await productRepository.getFeaturedProducts();

      // assign products
      featuredProducts.assignAll(products);
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// get the product price or price range of variations
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    // if not variations exits, return the simple price or sale price
    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toString();
    } else {
      // calculate the smallest and largest prices among variations
      for (var variation in product.productVariations!) {
        // determine the price to consider (sale price if available, otherwise regular price)
        double priceToConsider =
        variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        // update smallest and largest price
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }

        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        return '$smallestPrice - \$$largestPrice';
      }
    }
  }

  /// calculate discount percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0 ) return null;

    double percentage = ( (originalPrice - salePrice) / originalPrice) *100;
    return percentage.toStringAsFixed(0);
  }

  /// check product stock status
  String getProductStockStatus(int stock){
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  /// Selected attribute and variation
  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {

      final products = await productRepository.getAllFeaturedProducts();
      return products;
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
      return [];
    }
  }


}