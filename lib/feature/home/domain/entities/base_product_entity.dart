import 'package:goldooni/feature/home/domain/entities/amazing_products_entity.dart';
import 'package:goldooni/feature/home/domain/entities/new_products_entity.dart';
import 'package:goldooni/feature/home/domain/entities/top_products_entity.dart';

class BaseProductEntity {
  final int id;
  final String title;
  final int price;
  final String image;
  final int? discount;         
  final int? discountedPrice; 

  BaseProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    this.discount,
    this.discountedPrice,
  });
}
extension AmazingMapper on AmazingProductsEntity {
  BaseProductEntity toBase() {
    return BaseProductEntity(
      id: id,
      title: title,
      price: price,
      image: image,
      discount: discount,
      discountedPrice: discountedPrice,
    );
  }
}
extension NewMapper on NewProductsEntity {
  BaseProductEntity toBase() {
    return BaseProductEntity(
      id: id,
      title: title,
      price: price,
      image: image,
    );
  }
}

extension TopMapper on TopProductsEntity {
  BaseProductEntity toBase() {
    return BaseProductEntity(
      id: id,
      title: title,
      price: price,
      image: image,
    );
  }
}
