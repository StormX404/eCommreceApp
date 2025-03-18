import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants/colors.dart';
import '../constants/sizes.dart';

/// A widget for displaying an animated loading indicator with optional text & action button
class AAnimationLoaderWidget extends StatelessWidget {

  const AAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            animation,
            width: MediaQuery.of(context).size.width * 0.8,
          ), // Display Lottie animation
          const SizedBox(height: ASizes.defaultSpace),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: ASizes.defaultSpace),
          showAction
              ? SizedBox(
            width: 250,
            child: OutlinedButton(
              onPressed: onActionPressed,
              style:
              OutlinedButton.styleFrom(backgroundColor: AColors.dark),
              child: Text(
                actionText!,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: AColors.light),
              ),
            ),
          )
              : const SizedBox(),
        ],
      ),
    );
  }
}