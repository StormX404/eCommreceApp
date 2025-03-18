import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repos/user/user_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../data/models/user_model.dart';
import '../../data/repo/authentication_repository.dart';
import '../../screens/signup/verify_email_screen.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs; // observable for privacy policy acceptance
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // signup
  Future<void> signup() async {
    try {
      // start loading
      AFullScreenLoader.openLoadingDialog(
          'We are processing your information', AImages.docerAnimation);

      // check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // remove loader
        AFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!signupFormKey.currentState!.validate()) {
        // remove loader
        AFullScreenLoader.stopLoading();
        return;
      }

      // privacy policy check
      if (!privacyPolicy.value) {
        ALoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
            'In order to create account, you must have to read and accept the Privacy Policy and Terms of Use.');
        return;
      }

      // register user in the firebase authentication and save user data in the firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
          email.text.trim(), password.text.trim());

      // save authentication
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // remove loader
      AFullScreenLoader.stopLoading();

      // show success message
      ALoaders.successSnackBar(title: 'Congratulations', message: 'Your account has been created! Verify email to continue.');

      // move  to verify email screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));

    } catch (e) {
      // remove loader
      AFullScreenLoader.stopLoading();

      // show some generic error to the user
      ALoaders.errorSnackBar(title: e.toString());
    }
  }
}