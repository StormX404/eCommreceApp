import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../features/shop/models/relashtions/brand_category_model.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../services/firebase_storage_service.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  // vraiables
  final _db = FirebaseFirestore.instance;

  //  Get all categories
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();

      final result = snapshot.docs
          .map((element) => BrandModel.fromSnapshot(element))
          .toList();

      return result;
    } on FirebaseException catch (e) {
      throw AFirebaseException( e.code).message;
    } on PlatformException catch (e) {
      throw APlatformException( e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again:\n $e';
    }
  }

  // Get Brands for Category
  Future<List<BrandModel>> getBrandForCategory(categoryId) async {
    try {
      // Query to get all documents where category ld matches the provided categoryId
      QuerySnapshot brandCategoryQuery = await _db
          .collection('BrandCategory')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      // Extract brandIds from the documents
      List<String> brandId = brandCategoryQuery.docs
          .map((doc) => doc['brandId'] as String)
          .toList();

      // Query to get all documents where the brandId is in the list of brandIds, FieldPath.documentId to query documents in Collection
      final brandQuery = await _db
          .collection('Brands')
          .where(FieldPath.documentId, whereIn: brandId)
          .limit(2)
          .get();

      List<BrandModel> brands =
      brandQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();

      return brands;
    } on FirebaseException catch (e) {
      throw AFirebaseException( e.code).message;
    } on PlatformException catch (e) {
      throw APlatformException( e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again:\n $e';
    }
  }

  Future<void> uploadBrandsCategoriesRelationData(List<BrandCategoryModel> brandCategories) async {
    AFullScreenLoader.openLoadingDialog('Start Uploading...', AImages.loaderAnimation);
    final CollectionReference brandCategoryCollection =
    _db.collection('BrandCategory');

    try {
      for (var brandCategory in brandCategories) {
        await brandCategoryCollection.add(brandCategory.toJson());
        log("Uploaded ${brandCategory.brandId} - ${brandCategory.categoryId}");
      }
    } catch (e) {
      log("Error uploading data: $e");
      ALoaders.errorSnackBar(title: 'Error uploading', message: e.toString());
    } finally {
      AFullScreenLoader.stopLoading();
    }
  }

  /// Upload Banners to the Cloud Firebase
  Future<void> uploadDummyData(List<BrandModel> brands) async {
    if (brands.isEmpty) {
      throw 'No brands to upload.';
    }

    try {
      AFullScreenLoader.openLoadingDialog('Uploading Data...', AImages.loaderAnimation);
      final storage = Get.put(AFirebaseStorageService());

      for (var brand in brands) {
        // Check if the brand image path is valid
        if (brand.image.isEmpty) {
          throw 'Image path is missing for brand ${brand.name}';
        }

        // Attempt to get image data
        final file = await storage.getImageDataFromAssets(brand.image);

        // Upload image data and get URL
        final url = await storage.uploadImageData('Brands', file, brand.image);
        if (url.isEmpty) {
          throw 'Failed to upload image for ${brand.name}';
        }

        // Assign URL to brand's image attribute
        brand.image = url;

        // Store the brand in Firestore
        await _db.collection('Brands').doc(brand.id).set(brand.toJson());
      }
    } on FirebaseException catch (e) {
      throw AFirebaseException( e.code).message;
    } on PlatformException catch (e) {
      throw APlatformException( e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again: $e';
    } finally {
      AFullScreenLoader.stopLoading();
    }
  }
}