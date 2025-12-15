import 'user.dart';
import 'news_item.dart';

class FeedData {
  final User user;
  final List<NewsItem> trendingNews;
  final List<NewsItem> recommendations;

  FeedData({
    required this.user,
    required this.trendingNews,
    required this.recommendations,
  });
}