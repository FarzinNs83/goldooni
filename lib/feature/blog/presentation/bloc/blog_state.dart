part of 'blog_bloc.dart';

abstract class BlogState {}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<BlogEntity> blog;

  BlogLoaded({required this.blog});
}

class BlogFailed extends BlogState {
  final Failure failure;

  BlogFailed({required this.failure});

}
