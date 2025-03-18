import 'package:e_commerce_app/data/repos/brands/brand_repositry.dart';
import 'package:e_commerce_app/data/repos/product/product_repository.dart';
import 'package:get/get.dart';

import '../../../utils/popups/loaders.dart';
import '../models/brand_model.dart';
import '../models/product_model.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  final isLoading = true.obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> featureBrand = <BrandModel>[].obs;

  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    getFeatureBrands();
    super.onInit();
  }

  // Load Brands
  Future<void> getFeatureBrands() async {
    try {
      isLoading.value = true;

      final brands = await brandRepository.getAllBrands();

      allBrands.assignAll(brands);

      featureBrand.assignAll(allBrands
          .where(
            (brand) => brand.isFeatured ?? false,
      )
          .take(4));
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Get Brands For Category
  Future<List<BrandModel>> getBrandForCategory(String categoryId) async {
    try {
      final brands =
      await BrandRepository.instance.getBrandForCategory(categoryId);

      return brands;
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  // Get Brand Specific Products from your data source
  Future<List<ProductModel>> getBrandProducts(
      {required String brandId, int limit = -1}) async {
    try {
      final products = await ProductRepository.instance
          .getProductsForBrand(brandId: brandId, limit: limit);

      return products;
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}