import '../entities/feed_data.dart';

abstract class FeedRepository {
  Future<FeedData> getFeedData();
}