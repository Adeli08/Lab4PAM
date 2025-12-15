// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedDataModel _$FeedDataModelFromJson(Map<String, dynamic> json) =>
    FeedDataModel(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      trendingNews: (json['trending_news'] as List<dynamic>)
          .map((e) => NewsItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => NewsItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FeedDataModelToJson(FeedDataModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'trending_news': instance.trendingNews,
      'recommendations': instance.recommendations,
    };
