class BlogDetailEntity {
  final int id;
  final String image;
  final String title;
  final String author;
  final String body;
  final int like;
  final int dislike;

  BlogDetailEntity({
    required this.id,
    required this.image,
    required this.title,
    required this.author,
    required this.body,
    required this.like,
    required this.dislike,
  });
}
