import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/shop/controllers/all_product_contrroller.dart';
import '../../../utils/constants/colors.dart';

class DropdownWithContextMenu extends StatelessWidget {
  DropdownWithContextMenu({super.key, required this.sortController});

  final List<String> options = [
    'Name',
    'Higher Price',
    'Lower Price',
    'Sale',
  ];
  final AllProductController sortController;

  void _showCupertinoActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Select an option'),
        actions: options.map((String option) {
          return CupertinoActionSheetAction(
            child: Text(
              option,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .apply(color: AColors.primary),
            ),
            onPressed: () {
              sortController.sortProducts(option);
              Navigator.pop(context);
            },
          );
        }).toList(),
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .apply(color: Colors.red),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ValueListenableBuilder<String>(
        valueListenable: sortController.selectedSortOption,
        builder: (context, selectedValue, _) {
          return ListTile(
            leading: const Icon(Iconsax.sort),
            title: Text(selectedValue),
            onTap: () => _showCupertinoActionSheet(context),
            trailing: const Icon(Icons.arrow_drop_down),
          );
        },
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';

// class IOSDropdownField extends StatefulWidget {
//   const IOSDropdownField({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _IOSDropdownFieldState createState() => _IOSDropdownFieldState();
// }

// class _IOSDropdownFieldState extends State<IOSDropdownField> {
//   final List<String> options = [
//     'Name',
//     'Higher Price',
//     'Lower Price',
//     'Sale',
//     'Newest',
//     'Popularity'
//   ];
//   String selectedValue = 'Name';

//   void _showCupertinoPicker(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (_) {
//         return SizedBox(
//           height: 250,
//           child: CupertinoPicker(
//             backgroundColor: Colors.white,
//             itemExtent: 32,
//             onSelectedItemChanged: (int index) {
//               setState(() {
//                 selectedValue = options[index];
//               });
//             },
//             children: options.map((e) => Text(e)).toList(),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _showCupertinoPicker(context),
//       child: AbsorbPointer(
//         child: DropdownButtonFormField<String>(
//           decoration: const InputDecoration(
//             prefixIcon: Icon(Iconsax.sort),
//             labelText: 'Select an option',
//           ),
//           value: selectedValue,
//           onChanged: (value) {},
//           items: options.map((e) {
//             return DropdownMenuItem(value: e, child: Text(e));
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }