import 'package:goldooni/feature/home/domain/entities/cats_entity.dart';

class CatsModel extends CatsEntity {
  CatsModel({required super.id, required super.title, required super.icon});

  factory CatsModel.fromJson(Map<String, dynamic> json) {
    return CatsModel(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
    );
  }

  factory CatsModel.fromEntity(CatsEntity cats) {
    return CatsModel(
      id: cats.id,
      title: cats.title,
      icon: cats.title,
    );
  }
   
}
