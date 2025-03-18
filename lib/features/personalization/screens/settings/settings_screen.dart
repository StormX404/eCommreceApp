import 'package:e_commerce_app/features/authentication/data/repo/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/widgets/appbar/appbar.dart';
import '../../../../core/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../core/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../core/widgets/list_tiles/user_profile_tile.dart';
import '../../../../core/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../shop/screens/order/order_screen.dart';
import '../address/address_screen.dart';
import '../profile/profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            // -- Header
            APrimaryHeaderContainer(
              child: Column(
                children: [

                  /// -- AppBar
                  AAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: Colors.white),
                    ),
                  ),

                  // User Profile Card
                  AUserProfileTile(onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: ASizes.spaceBtwSections),
                ],
              ),
            ),

            // -- Body
            Padding(
              padding: const EdgeInsets.all(ASizes.defaultSpace),
              child: Column(
                children: [

                  /// -- Account Settings
                  const ASectionHeading(
                      title: 'Account Settings', showActionButton: false),
                  const SizedBox(height: ASizes.spaceBtwItems),

                  ASettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subTitle: 'Set shopping addresses',
                    onTap: () => Get.to(() => const AddressScreen()),
                  ),
                  const ASettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subTitle: 'Add, remove products & move to checkout',
                  ),
                  ASettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subTitle: 'In-progress & completed orders',
                    onTap: () => Get.to(() => const OrderScreen()),
                  ),
                  const ASettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subTitle: 'Withdraw balance to registered bank account',
                  ),
                  const ASettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'My Coupons',
                    subTitle: 'List of all discount coupons',
                  ),
                  const ASettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subTitle: 'Set any kind of notification message',
                  ),
                  const ASettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subTitle: 'Manage data usage & connected accounts',
                  ),

                  /// --- App Settings
                  const SizedBox(height: ASizes.spaceBtwSections),
                  const ASectionHeading(
                    title: 'App Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(height: ASizes.spaceBtwItems),
                  const ASettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Load Data',
                    subTitle: 'Upload Data to your Cloud Firestore',
                  ),
                  ASettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subTitle: 'Set recommendation based on location',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  ASettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subTitle: 'Search result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  ASettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD image Quality',
                    subTitle: 'Set image quality to be seen',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  /// --- Logout Button
                  const SizedBox(height: ASizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () async => {
                        await AuthenticationRepository.instance.logout(),
                      },
                      child: const Text('Logout'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
