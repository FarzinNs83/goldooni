class SingleProductEntity {
  final int id;
  final String title;
  final String description;
  final String mainImage;
  final int price;
  final int discount;
  final int finalPrice;
  final String status;
  final String createdAt;
  final String category;
  final List<dynamic> images;
  final List<dynamic> comments;
  final double averageStars;
  final int countComments;

  SingleProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.mainImage,
    required this.price,
    required this.discount,
    required this.finalPrice,
    required this.status,
    required this.createdAt,
    required this.category,
    required this.images,
    required this.comments,
    required this.averageStars,
    required this.countComments,
  });
}
