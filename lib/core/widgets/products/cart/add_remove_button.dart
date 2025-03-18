import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../icons/circular_icon.dart';

class AProductQuantityWithAddRemoveButton extends StatelessWidget {
  const AProductQuantityWithAddRemoveButton({
    super.key,
    required this.quantity,
    required this.add,
    required this.remove,
  });

  final int quantity;
  final VoidCallback add, remove;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ACircularIcon(
          onPressed: remove,
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: ASizes.md,
          color: AHelperFunctions.isDarkMode(context)
              ? AColors.white
              : AColors.black,
          backgroundColor: AHelperFunctions.isDarkMode(context)
              ? AColors.darkerGrey
              : AColors.light,
        ),
        const SizedBox(width: ASizes.spaceBtwItems),
        Text(quantity.toString(),
            style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(width: ASizes.spaceBtwItems),
        ACircularIcon(
          onPressed: add,
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: ASizes.md,
          color: AColors.white,
          backgroundColor: AColors.primary,
        ),
      ],
    );
  }
}

