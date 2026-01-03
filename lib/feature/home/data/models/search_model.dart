import 'package:goldooni/feature/home/domain/entities/search_entity.dart';

class SearchModel extends SearchEntity {
  SearchModel({
    required super.id,
    required super.title,
    required super.price,
    required super.discount,
    required super.finalPrice,
    required super.image,
  });
  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      discount: json['discount'],
      finalPrice: json['final_price'],
      image: json['main_image'],
    );
  }
}
