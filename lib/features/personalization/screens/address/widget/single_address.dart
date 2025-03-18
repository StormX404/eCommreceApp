import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/address_controller.dart';
import '../../../models/address_model.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({
    super.key,
    required this.addressModel,
    required this.onTap,
    this.onDelete,
  });

  final AddressModel addressModel;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = AHelperFunctions.isDarkMode(context);
    return Obx(
          () {
        final selectedAddressId = controller.selectedAddress.value.id;
        final selectedAddress = selectedAddressId == addressModel.id;
        return InkWell(
          onTap: onTap,
          child: ARoundedContainer(
            padding: const EdgeInsets.all(ASizes.md),
            width: double.infinity,
            showBorder: true,
            backgroundColor: selectedAddress
                ? AColors.primary.withValues(alpha: 0.5)
                : Colors.transparent,
            borderColor: selectedAddress
                ? Colors.transparent
                : dark
                ? AColors.darkerGrey
                : AColors.grey,
            margin: const EdgeInsets.only(bottom: ASizes.spaceBtwItems),
            child: Stack(
              children: [
                Positioned(
                  right: 5,
                  top: 0,
                  child: Icon(
                    selectedAddress ? Iconsax.tick_circle5 : null,
                    color: selectedAddress
                        ? dark
                        ? AColors.light
                        : AColors.primary
                        : null,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      addressModel.name,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: ASizes.sm / 2),
                    Text(
                      addressModel.formatedPhoneNumber,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: ASizes.sm / 2),
                    SizedBox(
                      width: 300,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        addressModel.toString(),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}