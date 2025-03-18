import 'package:e_commerce_app/features/shop/screens/order/widget/orders_list.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// -- AppBar
      appBar: AAppBar(
        title:
        Text('My Orders', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(ASizes.defaultSpace),

        /// -- Orders
        child: OrderListItems(),
      ),
    );
  }
}