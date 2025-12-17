
class CartEntity {
  final int id;
  final int totalPrice;
  final List<CartItemEntity> items;
  final String createdAt;
  final int user;

  CartEntity({
    required this.id,
    required this.totalPrice,
    required this.items,
    required this.createdAt,
    required this.user,
  });
}

class CartItemEntity {
  final int id;
  final ProductEntity product;
  final int totalPrice;
  final int quantity;

  CartItemEntity({
    required this.id,
    required this.product,
    required this.totalPrice,
    required this.quantity,
  });
}

class ProductEntity {
  final int id;
  final String title;
  final int price;
  final int discount;
  final int finalPrice;
  final String mainImage;

  ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.discount,
    required this.finalPrice,
    required this.mainImage,
  });
}
