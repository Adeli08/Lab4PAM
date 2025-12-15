import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/news_item.dart';

part 'news_item_model.g.dart';

@JsonSerializable()
class NewsItemModel extends NewsItem {
  @override
  @JsonKey(name: 'id')
  final int id;

  @override
  @JsonKey(name: 'category')
  final String category;

  @override
  @JsonKey(name: 'title')
  final String title;

  @override
  @JsonKey(name: 'publisher')
  final String publisher;

  @override
  @JsonKey(name: 'publisher_icon')
  final String publisherIcon;

  @override
  @JsonKey(name: 'image')
  final String image;

  @override
  @JsonKey(name: 'date')
  final String date;

  @override
  @JsonKey(name: 'is_verified', defaultValue: false, includeIfNull: true)
  final bool isVerified;

  @override
  @JsonKey(name: 'is_following')
  final bool? isFollowing;

  @JsonKey(name: 'publisher_verified')
  final bool? publisherVerified;

  NewsItemModel({
    required this.id,
    required this.category,
    required this.title,
    required this.publisher,
    required this.publisherIcon,
    required this.image,
    required this.date,
    required this.isVerified,
    this.isFollowing,
    this.publisherVerified,
  }) : super(
          id: id,
          category: category,
          title: title,
          publisher: publisher,
          publisherIcon: publisherIcon,
          image: image,
          date: date,
          isVerified: isVerified,
          isFollowing: isFollowing,
        );

  factory NewsItemModel.fromJson(Map<String, dynamic> json) => _$NewsItemModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$NewsItemModelToJson(this);
}