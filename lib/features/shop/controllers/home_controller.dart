import 'package:get/get.dart';

class HomeController extends GetxController{
  static HomeController get instance => Get.find();

  final carousalCurrentIndex  = 0.obs;
  final imageLoading = false.obs; // Start with loading as true

  void updatePageIndicator(index){
    carousalCurrentIndex.value = index;
  }

  // Call this function when all images are loaded
  void onImagesLoaded() {
    imageLoading.value = true;
  }
}