import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/category_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../services/firebase_storage_service.dart';

/// Repository class for category-related operations.
class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Get All Categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs.map((document) =>
          CategoryModel.fromSnapshot(document)).toList();
      return list;
    } on AFirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on AFormatException catch (_) {
      throw const AFormatException();
    } on APlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get Sub Categories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot = await _db.collection('Categories').where('ParentId',isEqualTo: categoryId).get();
      final result = snapshot.docs.map((document) =>
          CategoryModel.fromSnapshot(document)).toList();
      return result;
    } on AFirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on AFormatException catch (_) {
      throw const AFormatException();
    } on APlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Upload categories to the cloud firebase
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      final storage = Get.put(AFirebaseStorageService());

      // loop through each category
      for (var category in categories) {
        // get imageData link from the local assets
        final file = await storage.getImageDataFromAssets(category.image);

        // upload image and get its url
        final url = await storage.uploadImageData('Categories', file, category.name);

        // assign URL to Category.image attribute
        category.image = url;

        // store category in firestore
        await _db.collection('Categories').doc(category.id).set(category.toJson());
      }
    } on AFirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on AFormatException catch (_) {
      throw const AFormatException();
    } on APlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

}