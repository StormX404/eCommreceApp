import 'package:e_commerce_app/features/authentication/screens/signup/widgets/terms_and_condition_check_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/signup/signup_controller.dart';

class ASignupForm extends StatelessWidget {
  const ASignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          /// First and last name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      AValidator.displayNameValidator('First Name', value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: ATexts.firstName),
                ),
              ),
              const SizedBox(width: ASizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      AValidator.displayNameValidator('Last Name', value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: ATexts.lastName),
                ),
              ),
            ],
          ),
          const SizedBox(height: ASizes.spaceBtwInputFields),

          /// Username
          TextFormField(
            controller: controller.username,
            validator: (value) =>
                AValidator.displayNameValidator('Username', value),
            expands: false,
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.user_edit),
                labelText: ATexts.username),
          ),
          const SizedBox(height: ASizes.spaceBtwInputFields),

          /// Email
          TextFormField(
            controller: controller.email,
            validator: (value) => AValidator.validateEmail(value),
            expands: false,
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct), labelText: ATexts.email),
          ),
          const SizedBox(height: ASizes.spaceBtwInputFields),

          /// Phone number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => AValidator.validatePhoneNumber(value),
            expands: false,
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.call), labelText: ATexts.phoneNo),
          ),
          const SizedBox(height: ASizes.spaceBtwInputFields),

          /// Password
          Obx(
                () => TextFormField(
              controller: controller.password,
              validator: (value) => AValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value =
                  !controller.hidePassword.value,
                  icon: Icon( controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                ),
                labelText: ATexts.password,
              ),
            ),
          ),
          const SizedBox(height: ASizes.spaceBtwInputFields),

          /// Terms of use
          const ATermsAndConditionsCheckbox(),
          const SizedBox(height: ASizes.spaceBtwSections),

          /// Sign up button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(
                ATexts.createAccount,
              ),
            ),
          ),
        ],
      ),
    );
  }
}