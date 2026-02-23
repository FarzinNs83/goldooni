part of 'blog_bloc.dart';

abstract class BlogDetailState {}

class BlogDetailInitial extends BlogDetailState {}

class BlogDetailLoading extends BlogDetailState {}

class BlogDetailLoaded extends BlogDetailState {
  final BlogDetailEntity blog;

  BlogDetailLoaded({required this.blog});
}

class BlogDetailFailed extends BlogDetailState {
  final Failure failure;

  BlogDetailFailed({required this.failure});
}
