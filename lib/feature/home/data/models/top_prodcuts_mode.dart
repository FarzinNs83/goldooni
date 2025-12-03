import 'package:goldooni/feature/home/domain/entities/top_products_entity.dart';

class TopProductsModel extends TopProductsEntity {
  TopProductsModel({
    required super.id,
    required super.title,
    required super.price,
    required super.image,
  });
  factory TopProductsModel.fromJson(Map<String, dynamic> json) {
    return TopProductsModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      image: json['main_image'],
    );
  }
}
