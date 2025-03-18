import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../screens/login/login_screen.dart';
import '../../screens/onboarding/onboarding_screen.dart';
import '../../screens/signup/verify_email_screen.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../utils/exceptions/format_exceptions.dart';
import '../../../../utils/exceptions/platform_exceptions.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import '../../../../data/repos/user/user_repository.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // Get Authenticated User Data
  User get authUser => _auth.currentUser!;

  /// Called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Function to show relevant screen
  screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      if (user.emailVerified) {
        // Initialize User Specific Storage
        await ALocalStorage.init(user.uid);

        // if the user email is verified, navigate to the main Navigate Menu
        Get.offAll(() => const NavigationMenu());
      } else {
        // if the user's email is not verified, navigate to the VerifyEmailScreen
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      // Local Storage
      deviceStorage.writeIfNull('IsFirstTime', true);

      // check if its the first time launching the app
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(const OnBoardingScreen());
    }
  }

  /* --------------- Email and password sign-in ---------------------------- */

  /// [EmailAuthentication] - LOGIN
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on AFirebaseAuthException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on AFirebaseException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on AFormatException catch (_) {
      throw const AFormatException();
    } on APlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// [EmailAuthentication] - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on AFirebaseAuthException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on AFirebaseException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on AFormatException catch (_) {
      throw const AFormatException();
    } on APlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// [EmailAuthentication] - MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on AFirebaseAuthException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on AFirebaseException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on AFormatException catch (_) {
      throw const AFormatException();
    } on APlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// [ReAuthenticate] - RE AUTHENTICATE USER
  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
    try {
      // Create a credential
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

      // Re Authenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on AFirebaseAuthException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on AFirebaseException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on AFormatException catch (_) {
      throw const AFormatException();
    } on APlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// [EmailAuthentication] - FORGET PASSWORD
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on AFirebaseAuthException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on AFirebaseException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on AFormatException catch (_) {
      throw const AFormatException();
    } on APlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /*---------------- Federated identity and social sign-in -------------------*/

  /// [GoogleAuthentication] - GOOGLE
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await userAccount?.authentication;

      // Create a new credential
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      // Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credentials);
    } on AFirebaseAuthException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on AFirebaseException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on AFormatException catch (_) {
      throw const AFormatException();
    } on APlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something went wrong: $e');
      return null;
    }
  }

  /// [FacebookAuthentication] - FACEBOOK

  /*------------- end Federated identity and social sign-in ------------------*/

  /// [LogoutUser] valid for any authentication
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on AFirebaseAuthException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on AFirebaseException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on AFormatException catch (_) {
      throw const AFormatException();
    } on APlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// DELETE USER - Remove user Auth and FireStore Account
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
      Get.offAll(() => const LoginScreen());
    } on AFirebaseAuthException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on AFirebaseException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on AFormatException catch (_) {
      throw const AFormatException();
    } on APlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }


}