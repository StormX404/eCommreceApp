import 'package:e_commerce_app/utils/loaders/circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/texts/section_heading.dart';
import '../../../data/repos/address/address_repositry.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/cloud_helper_functions.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../models/address_model.dart';
import '../screens/address/add_new_address.dart';
import '../screens/address/widget/single_address.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final addressRepository = Get.put(AddressRepository());
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;

  final name = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  final phoneNumber = TextEditingController();

  final nameNode = FocusNode();
  final streetNode = FocusNode();
  final postalCodeNode = FocusNode();
  final cityNode = FocusNode();
  final stateNode = FocusNode();
  final countryNode = FocusNode();
  final phoneNumberNode = FocusNode();

  RxBool refreshData = true.obs;

  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  Future<List<AddressModel>> getAllUserAddress() async {
    try {
      final address = await addressRepository.fetchUserAddress();
      selectedAddress.value = address.firstWhere(
            (element) => element.selectedAddress,
        orElse: () => AddressModel.empty(),
      );
      return address;
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Address Not Found', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
          title: '',
          onWillPop: () async => false,
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          content: const ACircularLoader());

      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }

      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);

      Get.back();
    } catch (e) {
      ALoaders.errorSnackBar(
          title: 'Error in Selections', message: e.toString());
    }
  }

  Future addNewAddress() async {
    try {
      // loading
      AFullScreenLoader.openLoadingDialog(
          'Storing Address...', AImages.loaderAnimation);

      // check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      if (!addressFormKey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }

      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
      );

      final id = await addressRepository.addAddress(address);

      address.id = id;
      await selectAddress(address);

      AFullScreenLoader.stopLoading();

      ALoaders.successSnackBar(
        title: 'Congratulations',
        message: 'your address has been saved successfully.',
      );

      refreshData.toggle();

      resetFormFields();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Address Not Found', message: e.toString());
    }
  }

  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    state.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }

  Future<void> deleteAddress(String addressId) async {
    try {
      // Show a loading indicator
      Get.defaultDialog(
        title: '',
        onWillPop: () async => false,
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const ACircularLoader(),
      );

      // Delete the address from the repository
      await addressRepository.deleteAddress(addressId);

      // Refresh the address list
      refreshData.toggle();

      // Close the loading indicator
      Get.back();

      // Show success message
      ALoaders.successSnackBar(
        title: 'Success',
        message: 'Address deleted successfully.',
      );
    } catch (e) {
      Get.back();
      ALoaders.errorSnackBar(title: 'Deletion Failed', message: e.toString());
    }
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(ASizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ASectionHeading(title: 'Select Address', showActionButton: false),
            const SizedBox(height: ASizes.spaceBtwItems),
            FutureBuilder(
              future: getAllUserAddress(),
              builder: (context, snapshot) {
                final response = ACloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot);
                if (response != null) return response;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => SingleAddress(
                    addressModel: snapshot.data![index],
                    onTap: () async {
                      await selectAddress(snapshot.data![index]);
                      Get.back();
                    },
                  ),
                );
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const AddNewAddressScreen()),
                child: const Text('Add New Address'),
              ),
            )
          ],
        ),
      ),
    );
  }
}