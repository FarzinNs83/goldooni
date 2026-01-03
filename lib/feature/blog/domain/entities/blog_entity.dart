class BlogEntity {
  final int id;
  final String image;
  final String title;
  final int author;
  final String body;
  final int like;
  final int dislike;

  BlogEntity({
    required this.id,
    required this.image,
    required this.title,
    required this.author,
    required this.body,
    required this.like,
    required this.dislike,
  });
}
