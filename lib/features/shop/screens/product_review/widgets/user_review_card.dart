import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../../core/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../core/widgets/ratings/rating_indicator.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AHelperFunctions.isDarkMode(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                    backgroundImage: AssetImage(AImages.userProfileImage1)),
                const SizedBox(width: ASizes.spaceBtwItems),
                Text('John Doe', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        const SizedBox(height: ASizes.spaceBtwItems),

        /// Review
        Row(
          children: [
            const ARatingBarIndicator(rating: 4),
            const SizedBox(width: ASizes.spaceBtwItems),
            Text('01 Nov, 2023', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: ASizes.spaceBtwItems),
        const ReadMoreText(
          'The user interface of the app is quite intuitive. I was able to navigate & make purchases seamlessly. great job!!',
          trimMode: TrimMode.Line,
          trimExpandedText: ' show less',
          trimCollapsedText: ' show more',
          moreStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AColors.primary),
          lessStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AColors.primary),
        ),
        const SizedBox(height: ASizes.spaceBtwItems),

        /// Company Review
        ARoundedContainer(
            backgroundColor: dark ? AColors.darkerGrey : AColors.grey,
            child: Padding(
              padding: const EdgeInsets.all(ASizes.md),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("T's Store", style: Theme.of(context).textTheme.titleMedium),
                      Text("02 Nov, 2023", style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const SizedBox(height: ASizes.spaceBtwItems),
                  const ReadMoreText(
                    'The user interface of the app is quite intuitive. I was able to navigate & make purchases seamlessly. great job!!',
                    trimMode: TrimMode.Line,
                    trimExpandedText: ' show less',
                    trimCollapsedText: ' show more',
                    moreStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AColors.primary),
                    lessStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AColors.primary),
                  ),
                ],
              ),
            )
        ),
        const SizedBox(height: ASizes.spaceBtwSections),
      ],
    );
  }
}