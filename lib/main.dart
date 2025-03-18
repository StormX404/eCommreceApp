import 'package:e_commerce_app/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:e_commerce_app/routes/app_routes.dart';
import 'package:e_commerce_app/utils/constants/text_strings.dart';
import 'package:e_commerce_app/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/bindings/general_bindings.dart';
import 'features/authentication/data/repo/authentication_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Ensure Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Initialize Local Storage
  await GetStorage.init();

  // Initialize Firebase & Authentication
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then(
        (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );

  // Preserve Splash Screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Run the Application
  runApp(const ECommerceApp());
}

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: ATexts.appName,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.pages,
      home: const OnBoardingScreen(),
    );
  }
}
