
import '../features/shop/models/banner_model.dart';
import '../features/shop/models/brand_model.dart';
import '../features/shop/models/category_model.dart';
import '../features/shop/models/product_attribute_model.dart';
import '../features/shop/models/product_model.dart';
import '../features/shop/models/product_variation_model.dart';
import '../routes/routes.dart';
import '../utils/constants/image_strings.dart';

class TDummyData {
  // --- Banners
  static final List<BannerModel> banners = [
    BannerModel(
        imageUrl: AImages.promoBanner1,
        targetScreen: ARoutes.order,
        active: false),
    BannerModel(
        imageUrl: AImages.promoBanner2,
        targetScreen: ARoutes.cart,
        active: true),
    BannerModel(
        imageUrl: AImages.promoBanner3,
        targetScreen: ARoutes.favourites,
        active: true),
    BannerModel(
        imageUrl: AImages.promoBanner3,
        targetScreen: ARoutes.search,
        active: true),
  ];

  // --- User
  // static final UserModel user = UserModel(
  //   // id: id,
  //   firstName: 'Coding',
  //   lastName: 'with T',
  //   userName: 'khaled tarek',
  //   email: 'tkhaled238@gmail.com',
  //   phoneNumber: '01069785676',
  //   profilePicture: AImages.user,
  //   addresses: [
  //     AddressModel(
  //       id: '1',
  //       name: 'Coding with T',
  //       phoneNumber: '01069785676',
  //       street: '82356 Timmy Coves',
  //       state: 'Maine',
  //       postalCode: '87665',
  //       country: 'USA',
  //     ),
  //     AddressModel(
  //       id: '6',
  //       name: 'Coding with T',
  //       phoneNumber: '01069785676',
  //       street: '82356 Timmy Coves',
  //       state: 'Maine',
  //       postalCode: '87665',
  //       country: 'USA',
  //     ),
  //   ],
  // );

  // --- Cart
  // static final CartModel cart = CartModel(
  //   cartId: '001',
  //   items: [
  //     CartItemModel(
  //       productId:'001',
  //       variationId: '1',
  //       quantity: 1,
  //       title: products[0].title,
  //       image: products[0].thumbnail,
  //       brandName: products[0].brand!.name,
  //       price: products[0].productVariations![0].price,
  //       selectedVariation:products[0].productVariations![0].attributeValues,
  //     ),
  //     CartItemModel(
  //       productId:'001',
  //       variationId: '1',
  //       quantity: 1,
  //       title: products[0].title,
  //       image: products[0].thumbnail,
  //       brandName: products[0].brand!.name,
  //       price: products[0].productVariations![0].price,
  //       selectedVariation:products[0].productVariations![0].attributeValues,
  //     ),
  //   ],
  // );

  // --- Order
  // static final List<OrderModel> orders = [
  //   OrderModel(
  //     id:'CWT0012',
  //     status:OrderStatus.processing,
  //     items: cart.items,
  //     totalAmount:256,
  //     orderDate: DateTime(2023 , 09 , 1),
  //     deliveryDate: DateTime(2023 , 09 , 9),
  //   ),
  //   OrderModel(
  //     id:'CWT0012',
  //     status:OrderStatus.processing,
  //     items: cart.items,
  //     totalAmount:256,
  //     orderDate: DateTime(2023 , 09 , 1),
  //     deliveryDate: DateTime(2023 , 09 , 9),
  //   ),
  // ];

  // --- List of all Categories
 /* static final List<CategoryModel> categories = [
    CategoryModel(
        id: '1', image: AImages.sports, name: 'Sports', isFeatured: true),
    CategoryModel(
        id: '2',
        image: AImages.electronics,
        name: 'Electronics',
        isFeatured: true),
    CategoryModel(
        id: '3', image: AImages.clothes, name: 'Clothes', isFeatured: true),
    CategoryModel(
        id: '4', image: AImages.animals, name: 'Animals', isFeatured: true),
    CategoryModel(
        id: '5', image: AImages.furniture, name: 'Furniture', isFeatured: true),
    CategoryModel(
        id: '6', image: AImages.shoes, name: 'Shoes', isFeatured: true),
    CategoryModel(
        id: '7',
        image: AImages.cosmestics,
        name: 'Cosmetics',
        isFeatured: true),
    CategoryModel(
        id: '14', image: AImages.jewerly, name: 'Jewelery', isFeatured: true),

    // subcotegories Sports
    CategoryModel(
        id: '8',
        image: AImages.sports,
        name: 'Sports Shoes',
        parentId: '1',
        isFeatured: false),
    CategoryModel(
        id: '9',
        image: AImages.sports,
        name: 'Track Suits',
        parentId: '1',
        isFeatured: false),
    CategoryModel(
        id: '10',
        image: AImages.sports,
        name: 'Sports Equipments',
        parentId: '1',
        isFeatured: false),

    // subcotegories Furniture
    CategoryModel(
        id: '11',
        image: AImages.furniture,
        name: 'Bedroom Furniture',
        parentId: '5',
        isFeatured: false),
    CategoryModel(
        id: '12',
        image: AImages.furniture,
        name: 'Kitchen Furniture',
        parentId: '5',
        isFeatured: false),
    CategoryModel(
        id: '13',
        image: AImages.furniture,
        name: 'Office Furniture',
        parentId: '5',
        isFeatured: false),

    // subcotegories Electronics
    CategoryModel(
        id: '14',
        image: AImages.electronics,
        parentId: '2',
        name: 'Laptop',
        isFeatured: false),
    CategoryModel(
        id: '15',
        image: AImages.electronics,
        name: 'Mobile',
        parentId: '2',
        isFeatured: false),

    // subcotegories Clothes
    CategoryModel(
        id: '16',
        image: AImages.clothIcon,
        name: 'Shirts',
        parentId: '3',
        isFeatured: false),
  ];*/

  // --- List of all products
  static final List<ProductModel> products = [

    ProductModel(
      id: '018',
      title: 'Men\'s Classic Polo Shirt',
      stock: 150,
      price: 180,
      isFeatured: true,
      thumbnail: 'https://tfvkgqmsemxtixvaidnx.supabase.co/storage/v1/object/public/Photos/assets/images/products/product-shirt_blue_1.png',
      description: 'The Nike Air Jordan Black Red features a bold black leather upper with striking red accents, delivering a classic and timeless look. ',
      brand: BrandModel(
          id: '9',
          name: 'PUMA',
          image: 'https://tfvkgqmsemxtixvaidnx.supabase.co/storage/v1/object/public/Photos/assets/icons/brands/puma-logo.png',
          productsCount: 300,
          isFeatured: true),
      images: [
        'https://tfvkgqmsemxtixvaidnx.supabase.co/storage/v1/object/public/Photos/assets/images/products/product-shirt_blue_1.png',
        'https://tfvkgqmsemxtixvaidnx.supabase.co/storage/v1/object/public/Photos/assets/images/products/tshirt_red_collar.png',
        'https://tfvkgqmsemxtixvaidnx.supabase.co/storage/v1/object/public/Photos/assets/images/products/tshirt_yellow_collar.png',
      ],
      salePrice: 160,
      sku: 'ABR4568',
      categoryId: '3',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Blue', 'Red', 'Yellow']),
        ProductAttributeModel(name: 'Size', values: ['Small', 'Large']),
      ],
      productVariations: [
        ProductVariationModel(
            id: '1',
            stock: 34,
            price: 134,
            salePrice: 122.6,
            image: 'https://tfvkgqmsemxtixvaidnx.supabase.co/storage/v1/object/public/Photos/assets/images/products/product-shirt_blue_1.png',
            description:
            'The Nike Air Jordan Black Red.',
            attributesValues: {'Color': 'Blue', 'Size': 'Small'}),
        ProductVariationModel(
            id: '2',
            stock: 15,
            price: 162,
            image: 'https://tfvkgqmsemxtixvaidnx.supabase.co/storage/v1/object/public/Photos/assets/images/products/product-shirt_blue_1.png',
            attributesValues: {'Color': 'Blue', 'Size': 'Large'}),
        ProductVariationModel(
            id: '3',
            stock: 34,
            price: 134,
            salePrice: 122.6,
            image: 'https://tfvkgqmsemxtixvaidnx.supabase.co/storage/v1/object/public/Photos/assets/images/products/tshirt_red_collar.png',
            description:
            'The Nike Air Jordan Black Red.',
            attributesValues: {'Color': 'Red', 'Size': 'Small'}),
        ProductVariationModel(
            id: '4',
            stock: 15,
            price: 162,
            image: 'https://tfvkgqmsemxtixvaidnx.supabase.co/storage/v1/object/public/Photos/assets/images/products/tshirt_red_collar.png',
            attributesValues: {'Color': 'Red', 'Size': 'Large'}),
        ProductVariationModel(
            id: '5',
            stock: 34,
            price: 134,
            salePrice: 122.6,
            image: 'https://tfvkgqmsemxtixvaidnx.supabase.co/storage/v1/object/public/Photos/assets/images/products/tshirt_yellow_collar.png',
            description:
            'The Nike Air Jordan Black Red.',
            attributesValues: {'Color': 'Yellow', 'Size': 'Small'}),
        ProductVariationModel(
            id: '6',
            stock: 15,
            price: 162,
            image: 'https://tfvkgqmsemxtixvaidnx.supabase.co/storage/v1/object/public/Photos/assets/images/products/tshirt_yellow_collar.png',
            attributesValues: {'Color': 'Yellow', 'Size': 'Large'}),
      ],
      productType: 'ProductType.variable',
    ),
  ];

  /*static final List<BrandModel> brands = [
    BrandModel(
        id: '1',
        name: 'NIKE',
        image: AImages.nikeLogo,
        productsCount: 265,
        isFeatured: true),
    BrandModel(
        id: '2',
        name: 'ZARA',
        image: AImages.zaraLogo,
        productsCount: 300,
        isFeatured: true),
    BrandModel(
        id: '3',
        name: 'ACER',
        image: AImages.acerLogo,
        productsCount: 50,
        isFeatured: true),
    BrandModel(
        id: '4',
        name: 'ADIDAS',
        image: AImages.adidasLogo,
        productsCount: 212,
        isFeatured: true),
    BrandModel(
        id: '5',
        name: 'APPLE',
        image: AImages.appleLogo,
        productsCount: 120,
        isFeatured: true),
    BrandModel(
        id: '6',
        name: 'IKEA',
        image: AImages.ikeyalogo,
        productsCount: 320,
        isFeatured: true),
    BrandModel(
        id: '7',
        name: 'JORDAN',
        image: AImages.jordanLogo,
        productsCount: 265,
        isFeatured: true),
    BrandModel(
        id: '8',
        name: 'KENWOOD',
        image: AImages.kenwoodLogo,
        productsCount: 150,
        isFeatured: true),
    BrandModel(
        id: '9',
        name: 'PUMA',
        image: AImages.pumaLogo,
        productsCount: 265,
        isFeatured: true),
    BrandModel(
        id: '10',
        name: 'SAMSOUNG',
        image: AImages.smasoungLogo,
        productsCount: 265,
        isFeatured: true),
  ];

  static final List<BrandCategoryModel> brandCategory = [
    BrandCategoryModel(brandId: '1', categoryId: '1'),
    BrandCategoryModel(brandId: '4', categoryId: '1'),
    BrandCategoryModel(brandId: '10', categoryId: '2'),
    BrandCategoryModel(brandId: '5', categoryId: '2'),
    BrandCategoryModel(brandId: '6', categoryId: '3'),
    BrandCategoryModel(brandId: '2', categoryId: '3'),
    BrandCategoryModel(brandId: '7', categoryId: '3'),
    BrandCategoryModel(brandId: '8', categoryId: '4'),
    BrandCategoryModel(brandId: '9', categoryId: '4'),
    BrandCategoryModel(brandId: '3', categoryId: '5'),
    BrandCategoryModel(brandId: '6', categoryId: '5'),
    BrandCategoryModel(brandId: '1', categoryId: '6'),
    BrandCategoryModel(brandId: '4', categoryId: '6'),
    BrandCategoryModel(brandId: '7', categoryId: '6'),
    BrandCategoryModel(brandId: '2', categoryId: '7'),
    BrandCategoryModel(brandId: '1', categoryId: '7'),
    BrandCategoryModel(brandId: '8', categoryId: '8'),
    BrandCategoryModel(brandId: '2', categoryId: '8'),
  ];

  static final List<ProductCategoryModel> productCategories = products
      .map((product) => ProductCategoryModel(
    productId: product.id,
    categoryId: product.categoryId!,
  ))
      .toList();*/
}