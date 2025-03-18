import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadProduct() async {
    try {
      final productData = {
        'Id': '018',
        'Title': "Men's Classic Polo Shirt",
        'Stock': 150,
        'Price': 180,
        'IsFeatured': true,
        'Thumbnail': 'https://tfvkgqmsemxtixvaidnx.supabase.co/storage/v1/object/public/Photos/assets/images/products/product-shirt_blue_1.png',
        'Description': 'A stylish and comfortable polo shirt, perfect for casual wear.',
        'Brand': {
          'Id': '9',
          'Name': 'PUMA',
          'Image': 'https://tfvkgqmsemxtixvaidnx.supabase.co/storage/v1/object/public/Photos/assets/icons/brands/puma-logo.png',
          'ProductsCount': 300,
          'IsFeatured': true,
        },
        'Images': [
          'https://tfvkgqmsemxtixvaidnx.supabase.co/storage/v1/object/public/Photos/assets/images/products/product-shirt_blue_1.png',
          'https://tfvkgqmsemxtixvaidnx.supabase.co/storage/v1/object/public/Photos/assets/images/products/tshirt_red_collar.png',
          'https://tfvkgqmsemxtixvaidnx.supabase.co/storage/v1/object/public/Photos/assets/images/products/tshirt_yellow_collar.png',
        ],
        'SalePrice': 160,
        'Sku': 'ABR4568',
        'CategoryId': '3',
        'ProductAttributes': [
          {'Name': 'Color', 'Values': ['Blue', 'Red', 'Yellow']},
          {'Name': 'Size', 'Values': ['Small', 'Large']},
        ],
        'ProductVariations': [
          {
            'Id': '1',
            'Stock': 34,
            'Price': 134,
            'SalePrice': 122.6,
            'Image': 'https://tfvkgqmsemxtixvaidnx.supabase.co/storage/v1/object/public/Photos/assets/images/products/product-shirt_blue_1.png',
            'Description': 'Blue Polo Shirt - Small Size',
            'AttributesValues': {'Color': 'Blue', 'Size': 'Small'}
          },
          {
            'Id': '2',
            'Stock': 15,
            'Price': 162,
            'Image': 'https://tfvkgqmsemxtixvaidnx.supabase.co/storage/v1/object/public/Photos/assets/images/products/product-shirt_blue_1.png',
            'AttributesValues': {'Color': 'Blue', 'Size': 'Large'}
          },
          {
            'Id': '3',
            'Stock': 34,
            'Price': 134,
            'salePrice': 122.6,
            'Image': 'https://tfvkgqmsemxtixvaidnx.supabase.co/storage/v1/object/public/Photos/assets/images/products/tshirt_red_collar.png',
            'Description': 'Red Polo Shirt - Small Size',
            'AttributesValues': {'Color': 'Red', 'Size': 'Small'}
          },
          {
            'Id': '4',
            'Stock': 15,
            'Price': 162,
            'Image': 'https://tfvkgqmsemxtixvaidnx.supabase.co/storage/v1/object/public/Photos/assets/images/products/tshirt_red_collar.png',
            'AttributesValues': {'Color': 'Red', 'Size': 'Large'}
          },
          {
            'Id': '5',
            'Stock': 34,
            'Price': 134,
            'SalePrice': 122.6,
            'Image': 'https://tfvkgqmsemxtixvaidnx.supabase.co/storage/v1/object/public/Photos/assets/images/products/tshirt_yellow_collar.png',
            'Description': 'Yellow Polo Shirt - Small Size',
            'AttributesValues': {'Color': 'Yellow', 'Size': 'Small'}
          },
          {
            'Id': '6',
            'Stock': 15,
            'Price': 162,
            'Image': 'https://tfvkgqmsemxtixvaidnx.supabase.co/storage/v1/object/public/Photos/assets/images/products/tshirt_yellow_collar.png',
            'AttributesValues': {'Color': 'Yellow', 'Size': 'Large'}
          },
        ],
        'ProductType': 'ProductType.variable',
      };

      await _firestore.collection('Products').doc(productData['Id'] as String?).set(productData);

      print('✅ Product uploaded successfully!');
    } catch (e) {
      print('❌ Error uploading product: $e');
    }
  }
}
