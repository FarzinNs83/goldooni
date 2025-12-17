import 'package:goldooni/feature/home/domain/entities/amazing_products_entity.dart';

class AmazingProductsModel extends AmazingProductsEntity {
  AmazingProductsModel({
    required super.id,
    required super.title,
    required super.price,
    required super.discount,
    required super.discountedPrice,
    required super.image,
  });
  factory AmazingProductsModel.fromJson(Map<String, dynamic> json) {
    return AmazingProductsModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      discount: json['discount'],
      discountedPrice: json['final_price'],
      image: json['main_image'],
    );
  }
}
