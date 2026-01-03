import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goldooni/core/errors/failure.dart';
import 'package:goldooni/feature/blog/domain/entities/blog_entity.dart';
import 'package:goldooni/feature/blog/domain/repositories/blog_repository.dart';
part 'blog_state.dart';

class BlogBloc extends Cubit<BlogState> {
  final BlogRepository blogRepo;
  BlogBloc(this.blogRepo) : super(BlogInitial()) {
    getBlogs();
  }
  Future<void> getBlogs() async {
    emit(BlogLoading());
    try {
      final blogs = await blogRepo.getBlogs();
      log("blogs: $blogs");
      emit(BlogLoaded(blog: blogs));
    } catch (e) {
      emit(BlogFailed(failure: Failure(e.toString())));
    }
  }
}
