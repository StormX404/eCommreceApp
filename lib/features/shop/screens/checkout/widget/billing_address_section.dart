import 'package:flutter/material.dart';

import '../../../../../core/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../personalization/controllers/address_controller.dart';

class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    // final dark = THelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Heading address
        ASectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () => addressController.selectNewAddressPopup(context),
        ),

        /// display information about address
        addressController.selectedAddress.value.id.isNotEmpty
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(addressController.selectedAddress.value.name,
                style: Theme.of(context).textTheme.bodyLarge),
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.grey, size: 16),
                const SizedBox(width: ASizes.spaceBtwItems),
                Text(addressController.selectedAddress.value.phoneNumber,
                    style: Theme.of(context).textTheme.bodyMedium)
              ],
            ),
            const SizedBox(height: ASizes.spaceBtwItems / 2),
            Row(
              children: [
                const Icon(Icons.location_history,
                    color: Colors.grey, size: 16),
                const SizedBox(width: ASizes.spaceBtwItems),
                Expanded(
                  child: Text(
                    [
                      addressController.selectedAddress.value.country,
                      addressController.selectedAddress.value.city,
                      addressController.selectedAddress.value.street,
                    ].where((element) => element.isNotEmpty).join(', '),
                    style: Theme.of(context).textTheme.bodyMedium,
                    softWrap: true,
                  ),
                )
              ],
            )
          ],
        )
            : Text('Select Address',
            style: Theme.of(context).textTheme.bodyMedium)
      ],
    );
  }
}