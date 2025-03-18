import 'package:e_commerce_app/features/authentication/screens/login/widgets/login_form.dart';
import 'package:e_commerce_app/features/authentication/screens/login/widgets/login_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/styles/spacing_styles.dart';
import '../../../../core/widgets/login_signup/form_divider.dart';
import '../../../../core/widgets/login_signup/social_button.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: ASpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              // Logo title, subtitle
              const ALoginHeader(),

              // Form
              const ALoginForm(),

              /// Divider
              AFormDivider( dividerText: ATexts.orSignInWith.capitalize!),
              const SizedBox(
                height: ASizes.spaceBtwSections,
              ),

              /// Footer
              const ASocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}





