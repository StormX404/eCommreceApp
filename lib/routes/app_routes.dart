import 'package:e_commerce_app/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:e_commerce_app/features/personalization/screens/settings/settings_screen.dart';
import 'package:e_commerce_app/features/shop/screens/product_review/product_review_screen.dart';
import 'package:e_commerce_app/features/shop/screens/wishlist/wishlist.dart';
import 'package:e_commerce_app/routes/routes.dart';
import 'package:get/get.dart';

import '../features/authentication/screens/login/login_screen.dart';
import '../features/authentication/screens/password_configuration/forget_password_screen.dart';
import '../features/authentication/screens/signup/signup_screen.dart';
import '../features/authentication/screens/signup/verify_email_screen.dart';
import '../features/personalization/screens/address/address_screen.dart';
import '../features/personalization/screens/profile/profile_screen.dart';
import '../features/shop/models/product_model.dart';
import '../features/shop/screens/cart/cart_screen.dart';
import '../features/shop/screens/checkout/checkout.dart';
import '../features/shop/screens/home/home_screen.dart';
import '../features/shop/screens/order/order_screen.dart';
import '../features/shop/screens/product_details/product_detail_screen.dart';
import '../features/shop/screens/store/store_screen.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: ARoutes.home, page: () => const HomeScreen()),
    GetPage(name: ARoutes.store, page: () => const StoreScreen()),
    GetPage(name: ARoutes.favourites, page: () => const FavouriteScreen()),
    GetPage(name: ARoutes.settings, page: () => const SettingsScreen()),
    GetPage(name: ARoutes.productReviews, page: () => const ProductReviewScreen()),
    GetPage(name: ARoutes.order, page: () => const OrderScreen()),
    GetPage(name: ARoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: ARoutes.cart, page: () => const CartScreen()),
    GetPage(name: ARoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: ARoutes.signup, page: () => const SignupScreen()),
    GetPage(name: ARoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: ARoutes.signIn, page: () => const LoginScreen()),
    GetPage(
        name: ARoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(name: ARoutes.onBoarding, page: () => const OnBoardingScreen()),
     GetPage(
        name: ARoutes.productDetail,
        page: () => ProductDetailScreen(product: ProductModel.empty())),
    GetPage(name: ARoutes.userAddress, page: () => const AddressScreen()),
  ];
}