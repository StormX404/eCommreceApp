import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/widgets/checkout/payment_tile.dart';
import '../../../utils/constants/image_strings.dart';
import '../models/payment_method_model.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value =
        PaymentMethodModel(name: 'Paypal', image: AImages.paypal);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) async {
    final selected = await showCupertinoModalPopup<String>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Select Payment Method'),
        message: const Text('Choose your preferred payment option'),
        actions: [
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'Paypal');
              },
              child: APaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Paypal', image: AImages.paypal))),
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'Google Pay');
              },
              child: APaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Google Pay', image: AImages.googlePay))),
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'Apple Pay');
              },
              child: APaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Apple Pay', image: AImages.applePay))),
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'VISA');
              },
              child: APaymentTile(
                  paymentMethod:
                  PaymentMethodModel(name: 'VISA', image: AImages.visa))),
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'Master Card');
              },
              child: APaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Master Card', image: AImages.masterCard))),
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'Paytm');
              },
              child: APaymentTile(
                  paymentMethod:
                  PaymentMethodModel(name: 'Paytm', image: AImages.paytm))),
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'PayStack');
              },
              child: APaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'PayStack', image: AImages.paystack))),
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'Credit Card');
              },
              child: APaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Credit Card', image: AImages.creditCard))),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          isDefaultAction: true,
          child: const Text('Cancel'),
        ),
      ),
    );

    if (selected != null) {
      // Update the selected payment method
      selectedPaymentMethod.value = PaymentMethodModel(
        name: selected,
        image: getImageForPaymentMethod(selected),
      );
    }
  }


  String getImageForPaymentMethod(String methodName) {
    switch (methodName) {
      case 'Paypal':
        return AImages.paypal;
      case 'Google Pay':
        return AImages.googlePay;
      case 'Apple Pay':
        return AImages.applePay;
      case 'VISA':
        return AImages.visa;
      case 'Master Card':
        return AImages.masterCard;
      case 'Paytm':
        return AImages.paytm;
      case 'PayStack':
        return AImages.paystack;
      case 'Credit Card':
        return AImages.creditCard;
      default:
        return ''; // Fallback image if needed
    }
  }


}