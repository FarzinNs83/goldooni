import '../entities/blog_entity.dart';

abstract class BlogDetailRepository {
  Future<BlogDetailEntity> getBlogDetails({required int id});
}
