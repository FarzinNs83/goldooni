import '../../domain/entities/cats_entity.dart';

class CatsModel extends CatsEntity {
  CatsModel({
    required super.id,
    required super.title,
    required super.price,
    required super.discount,
    required super.discountedPrice,
    required super.image,
  });

  factory CatsModel.fromJson(Map<String, dynamic> json) {
    return CatsModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      discount: json['discount'],
      discountedPrice: json['final_price'],
      image: json['main_image'],
    );
  }
}
