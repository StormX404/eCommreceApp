import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controllers/update_name_controller.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: AAppBar(
        showBackArrow: true,
        title: Text(
          'Change Name',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ASizes.defaultSpace,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Use real name for easy verfication. This name will apear on several pages' , style: Theme.of(context).textTheme.labelMedium,),
            const SizedBox(height: ASizes.spaceBtwSections,),

            /// Text field one Button
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) => AValidator.displayNameValidator('First name' , value),
                    decoration: const InputDecoration(labelText: ATexts.firstName, prefixIcon: Icon(Iconsax.user)),
                  ),
                  const SizedBox(height: ASizes.spaceBtwInputFields),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) => AValidator.displayNameValidator('Last name' , value),
                    decoration: const InputDecoration(labelText: ATexts.firstName, prefixIcon: Icon(Iconsax.user)),
                  ),
                ],
              )),
            const SizedBox(height: ASizes.spaceBtwSections,),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () => controller. updateUserName(), child: const Text( 'Save' )),
            ),
          ],
        ),
      ),
    );
  }
}
