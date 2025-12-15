import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/feed_repository.dart';
import 'feed_event.dart';
import 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedRepository feedRepository;

  FeedBloc({required this.feedRepository}) : super(FeedInitial()) {
    print('🎯 [BLoC] FeedBloc created with FeedRepository');
    
    on<LoadFeedEvent>((event, emit) async {
      print('🎯 [BLoC] LoadFeedEvent received!');
      print('🎯 [BLoC] Emitting FeedLoading state...');
      emit(FeedLoading());
      
      try {
        print('🎯 [BLoC] Calling feedRepository.getFeedData()...');
        final feedData = await feedRepository.getFeedData();
        print('✅ [BLoC] FeedData received from repository!');
        print('✅ [BLoC] Emitting FeedLoaded state...');
        emit(FeedLoaded(feedData: feedData));
        print('✅ [BLoC] FeedLoaded state emitted successfully!');
      } catch (e, stackTrace) {
        print('❌ [BLoC] Error occurred: $e');
        print('❌ [BLoC] Stack trace: $stackTrace');
        print('❌ [BLoC] Emitting FeedError state...');
        emit(FeedError(message: e.toString()));
        print('❌ [BLoC] FeedError state emitted with message: ${e.toString()}');
      }
    });
  }
}