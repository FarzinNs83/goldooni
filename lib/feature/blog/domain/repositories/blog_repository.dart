import '../entities/blog_entity.dart';

abstract class BlogRepository {
  Future<List<BlogEntity>> getBlogs();
}
