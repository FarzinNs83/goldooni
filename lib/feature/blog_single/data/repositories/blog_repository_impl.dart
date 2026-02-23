import '../../domain/entities/blog_entity.dart';
import '../../domain/repositories/blog_repository.dart';
import '../remote/blog_remote.dart';

class BlogDetailRepositoryImpl implements BlogDetailRepository {
  final BlogDetailRemote blogRemote;
  BlogDetailRepositoryImpl(this.blogRemote);

  @override
  Future<BlogDetailEntity> getBlogDetails({required int id}) {
    return blogRemote.getBlogDetail(id);
  }
}
