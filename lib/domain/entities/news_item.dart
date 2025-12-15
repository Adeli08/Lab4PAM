class NewsItem {
  final int id;
  final String category;
  final String title;
  final String publisher;
  final String publisherIcon;
  final String image;
  final String date;
  final bool isVerified;
  final bool? isFollowing; // Only for recommendations

  NewsItem({
    required this.id,
    required this.category,
    required this.title,
    required this.publisher,
    required this.publisherIcon,
    required this.image,
    required this.date,
    required this.isVerified,
    this.isFollowing,
  });
}