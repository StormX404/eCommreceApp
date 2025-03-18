import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/product_model.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  RxString selectedProductImage = ''.obs;

  // Get All Images from product and Variations
  List<String> getAllProductImages(ProductModel product) {
    // Use Set to add unique images one.
    Set<String> images = {};

    // Load thumbnail image
    images.add(product.thumbnail);
    selectedProductImage.value = product.thumbnail;

    // Get au images from the Product Model if not null.
    if (product.images != null) {
      images.addAll(product.images!);
    }

    // Get all images from the Product Variations if not null.
    if (product.productVariations != null &&
        product.productVariations!.isNotEmpty) {
      images.addAll(product.productVariations!.map((e) => e.image));
    }

    return images.toList();
  }

  // Show Image Popup
  void showEnlargeImage(BuildContext context, String image) {
    showGeneralDialog(
      context: context,
      barrierLabel: 'Dismiss', // Add this label to fix the error
      barrierColor: Colors.black.withValues(alpha: 0.3), // Background overlay
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return BackdropFilter(
          filter:
          ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Background blur effect
          child: Center(
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -1), // Start from the top
                end: Offset.zero, // End at the center
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Glass effect container for the image
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.4),
                          width: 5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: image,
                          width: 400,
                          height: 400,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Glass effect container for the close button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.4),
                          width: 1.5,
                        ),
                      ),
                      child: SizedBox(
                        width: 150,
                        child: CupertinoButton(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          borderRadius: BorderRadius.circular(10),
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            'Close',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1), // Slide from top
            end: Offset.zero, // Centered
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          )),
          child: child,
        );
      },
    );
  }
}


// Get.to(
//   fullscreenDialog: true,
//   () => Dialog.fullscreen(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(
//               vertical: TSizes.defultSpace * 2,
//               horizontal: TSizes.defultSpace),
//           child: CachedNetworkImage(imageUrl: image),
//         ),
//         const SizedBox(height: TSizes.spaceBtwScetions),
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: SizedBox(
//             width: 150,
//             child: OutlinedButton(
//                 onPressed: () => Get.back(), child: const Text('Close')),
//           ),
//         )
//       ],
//     ),
//   ),
// );