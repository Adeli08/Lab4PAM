import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/feed_data.dart';
import 'user_model.dart';
import 'news_item_model.dart';

part 'feed_data_model.g.dart';

@JsonSerializable()
class FeedDataModel extends FeedData {
  @override
  @JsonKey(name: 'user')
  final UserModel user;

  @override
  @JsonKey(name: 'trending_news')
  final List<NewsItemModel> trendingNews;

  @override
  @JsonKey(name: 'recommendations')
  final List<NewsItemModel> recommendations;

  FeedDataModel({
    required this.user,
    required this.trendingNews,
    required this.recommendations,
  }) : super(
          user: user,
          trendingNews: trendingNews,
          recommendations: recommendations,
        );

  factory FeedDataModel.fromJson(Map<String, dynamic> json) => _$FeedDataModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$FeedDataModelToJson(this);
}