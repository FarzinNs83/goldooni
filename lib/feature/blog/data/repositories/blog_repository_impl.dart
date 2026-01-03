import 'package:goldooni/feature/blog/data/remote/blog_remote.dart';
import 'package:goldooni/feature/blog/domain/entities/blog_entity.dart';

import '../../domain/repositories/blog_repository.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemote blogRemote;
  BlogRepositoryImpl(this.blogRemote);
  @override
  Future<List<BlogEntity>> getBlogs() {
    return blogRemote.getBlogs();
  }
}
