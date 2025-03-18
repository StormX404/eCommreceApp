import 'package:e_commerce_app/features/personalization/screens/address/widget/single_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/styles/custom_animator.dart';
import '../../../../core/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/address_controller.dart';
import 'add_new_address.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButtonAnimator: CustomAddAddressAnimator(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        backgroundColor: AColors.primary,
        child: const Icon(Iconsax.add, color: AColors.white),
      ),
      appBar: AAppBar(
          showBackArrow: true,
          title: Text('Address',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Obx(() {
            return FutureBuilder(
              key: Key(controller.refreshData.value.toString()),
              future: controller.getAllUserAddress(),
              builder: (context, snapshot) {
                final response = ACloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot);

                if (response != null) return response;
                final address = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: address.length,
                  itemBuilder: (context, index) {
                    final currentAddress = address[index];

                    return Dismissible(
                      key: Key(currentAddress.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.centerRight,
                        child: const Icon(Icons.delete, color: Colors.white, size: 30),
                      ),
                      confirmDismiss: (direction) async {
                        return await Get.defaultDialog<bool>(
                          title: "Delete Address",
                          middleText: "Are you sure you want to delete this address?",
                          textConfirm: "Yes",
                          textCancel: "No",
                          onConfirm: () => Get.back(result: true),
                          onCancel: () {},
                        );
                      },
                      onDismissed: (direction) async {
                        await controller.deleteAddress(currentAddress.id);
                      },
                      child: SingleAddress(
                        addressModel: currentAddress,
                        onTap: () => controller.selectAddress(currentAddress),
                      ),
                    );
                  },
                );

              },
            );
          }),
        ),
      ),
    );
  }
}