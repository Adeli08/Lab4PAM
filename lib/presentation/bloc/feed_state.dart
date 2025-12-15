import '../../domain/entities/feed_data.dart';

abstract class FeedState {}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final FeedData feedData;

  FeedLoaded({required this.feedData});
}

class FeedError extends FeedState {
  final String message;

  FeedError({required this.message});
}