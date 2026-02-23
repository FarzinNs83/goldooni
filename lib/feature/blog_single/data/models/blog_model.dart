import '../../domain/entities/blog_entity.dart';

class BlogDetailModel extends BlogDetailEntity {
  BlogDetailModel({
    required super.id,
    required super.image,
    required super.title,
    required super.author,
    required super.body,
    required super.like,
    required super.dislike,
  });

  factory BlogDetailModel.fromJson(Map<String, dynamic> json) {
    return BlogDetailModel(
      id: json['id'],
      image: json['image'],
      title: json['title'],
      author: json['author'],
      body: json['body'],
      like: json['likes_count'],
      dislike: json['dislikes_count'],
    );
  }
}
