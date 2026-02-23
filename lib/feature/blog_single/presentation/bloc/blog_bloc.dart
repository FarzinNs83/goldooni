import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goldooni/core/errors/failure.dart';
import 'package:goldooni/feature/blog_single/domain/entities/blog_entity.dart';

import '../../domain/repositories/blog_repository.dart';
part 'blog_state.dart';

class BlogDetailBloc extends Cubit<BlogDetailState> {
  final BlogDetailRepository blogRepo;
  BlogDetailBloc(this.blogRepo) : super(BlogDetailInitial());
  Future<void> getBlogDetails(int id) async {
    emit(BlogDetailLoading());
    try {
      final blogs = await blogRepo.getBlogDetails(id: id);
      log("blogs: $blogs");
      emit(BlogDetailLoaded(blog: blogs));
    } catch (e) {
      emit(BlogDetailFailed(failure: Failure(e.toString())));
    }
  }
}
