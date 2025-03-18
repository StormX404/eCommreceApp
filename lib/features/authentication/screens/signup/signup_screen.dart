import 'package:e_commerce_app/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/login_signup/form_divider.dart';
import '../../../../core/widgets/login_signup/social_button.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// title
              Text(
                ATexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: ASizes.spaceBtwSections,
              ),

              const ASignupForm(),
              const SizedBox(
                height: ASizes.spaceBtwSections,
              ),

              // divider
              AFormDivider(dividerText: ATexts.orSignUpWith.capitalize!,),
              const SizedBox(
                height: ASizes.spaceBtwSections,
              ),

              // footer
              const ASocialButtons(),
              const SizedBox(
                height: ASizes.spaceBtwSections,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

