class ProductDetails {
  String name;
  String caption;
  String imagePath;
  bool popularRental;
  String material;
  String dimensions;
  String color;
  String condition;

  ProductDetails({
    required this.name,
    required this.imagePath,
    required this.caption,
    required this.popularRental,
    required this.material,
    required this.dimensions,
    required this.color,
    required this.condition,
  });

  static List<ProductDetails> getProductDetails() {
    List<ProductDetails> productDetails = [];

    

    productDetails.add(
    ProductDetails(
      name: 'DJI Drone',
      imagePath: 'assets/images/drone.png',
      caption: 'Capture stunning aerial footage',
      popularRental: true,
      material: 'Plastic & Metal',
      dimensions: '30x30x10 cm',
      color: 'White',
      condition: 'New',
    ),
  );

  productDetails.add(
    ProductDetails(
      name: 'Canon Camera',
      imagePath: 'assets/images/camera.png',
      caption: 'Professional photography equipment',
      popularRental: true,
      material: 'Metal & Glass',
      dimensions: '15x10x8 cm',
      color: 'Black',
      condition: 'Used - Like New',
    ),
  );

  productDetails.add(
    ProductDetails(
      name: 'Bose Headphones',
      imagePath: 'assets/images/headphone.png',
      caption: 'Immersive audio experience',
      popularRental: true,
      material: 'Plastic & Leather',
      dimensions: '20x18x5 cm',
      color: 'Black',
      condition: 'New',
    ),
  );

  productDetails.add(
    ProductDetails(
      name: 'GoPro Hero 12',
      imagePath: 'assets/images/goPro.jpg',
      caption: 'Compact action camera for adventures',
      popularRental: false,
      material: 'Plastic & Glass',
      dimensions: '6x4x3 cm',
      color: 'Silver',
      condition: 'New',
    ),
  );

  productDetails.add(
    ProductDetails(
      name: 'Nikon DSLR',
      imagePath: 'assets/images/nikon.webp',
      caption: 'High-resolution DSLR camera',
      popularRental: false,
      material: 'Metal & Plastic',
      dimensions: '14x11x8 cm',
      color: 'Black',
      condition: 'Used - Good',
    ),
  );
    
    return productDetails;
  }
}