import '../../domain/entities/new_products_entity.dart';

class NewProductsModel extends NewProductsEntity {
  NewProductsModel({
    required super.id,
    required super.title,
    required super.price,
    required super.image,
  });
  factory NewProductsModel.fromJson(Map<String, dynamic> json) {
    return NewProductsModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      image: json['main_image'],
    );
  }
}
