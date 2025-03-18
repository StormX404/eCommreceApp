import 'package:e_commerce_app/features/shop/screens/product_review/widgets/rating_progress_indicator.dart';
import 'package:e_commerce_app/features/shop/screens/product_review/widgets/user_review_card.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/appbar/appbar.dart';
import '../../../../core/widgets/ratings/rating_indicator.dart';
import '../../../../utils/constants/sizes.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// -- Appbar
      appBar: const AAppBar(
        title: Text('Reviews & Ratings'),
        showBackArrow: true,
      ),

      /// -- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Ratings & reviews are verified and are from people who use the same type of device that you use'),
              const SizedBox(height: ASizes.spaceBtwItems),

              /// Overall Product Ratings
              const OverallProductRating(),
              const ARatingBarIndicator(rating: 3.5),
              Text('12,612', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: ASizes.spaceBtwSections),

              /// User Reviews List
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}

