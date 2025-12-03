import '../../domain/entities/single_product_entity.dart';

class SingleProductModel extends SingleProductEntity {
  SingleProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.mainImage,
    required super.price,
    required super.discount,
    required super.finalPrice,
    required super.status,
    required super.createdAt,
    required super.category,
    required super.images,
    required super.comments,
    required super.averageStars,
    required super.countComments,
  });

  factory SingleProductModel.fromJson(Map<String, dynamic> json) {
    return SingleProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      mainImage: json['main_image'],
      price: json['price'],
      discount: json['discount'],
      finalPrice: json['final_price'],
      status: json['status'],
      createdAt: json['created_at'],
      category: json['category'],
      images: json['images'],
      comments: json['comments'],
      averageStars: json['average_stars'],
      countComments: json['count_comments'],
    );
  }
}
