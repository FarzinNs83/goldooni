import 'package:goldooni/feature/home/domain/entities/search_cats_entity.dart';

class SearchCatsModel extends SearchCatsEntity{
  SearchCatsModel({required super.id, required super.title, required super.icon});
  factory SearchCatsModel.fromJson(Map<String, dynamic> json) {
    return SearchCatsModel(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
    );
  }
}