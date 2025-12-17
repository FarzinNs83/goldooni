import '../../domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  CartModel({
    required super.id,
    required super.totalPrice,
    required super.items,
    required super.createdAt,
    required super.user,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      totalPrice: json['total_price'],
      items: (json['items'] as List)
          .map((e) => CartItemModel.fromJson(e))
          .toList(),
      createdAt: json['created_at'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "total_price": totalPrice,
    "items": items.map((e) => (e as CartItemModel).toJson()).toList(),
    "created_at": createdAt,
    "user": user,
  };
}

class CartItemModel extends CartItemEntity {
  CartItemModel({
    required super.id,
    required super.product,
    required super.totalPrice,
    required super.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      product: ProductModel.fromJson(json['product']),
      totalPrice: json['total_price'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "product": (product as ProductModel).toJson(),
    "total_price": totalPrice,
    "quantity": quantity,
  };
}

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.discount,
    required super.finalPrice,
    required super.mainImage,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      discount: json['discount'],
      finalPrice: json['final_price'],
      mainImage: json['main_image'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "discount": discount,
    "final_price": finalPrice,
    "main_image": mainImage,
  };
}
