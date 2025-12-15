import '../../domain/entities/feed_data.dart';
import '../../domain/repositories/feed_repository.dart';
import '../datasources/remote_data_source.dart';

class FeedRepositoryImpl implements FeedRepository {
  final RemoteDataSource remoteDataSource;

  FeedRepositoryImpl({required this.remoteDataSource});

  @override
  Future<FeedData> getFeedData() async {
    print('📚 [Repository] getFeedData() called');
    try {
      print('📚 [Repository] Calling remoteDataSource.getFeedData()...');
      final feedData = await remoteDataSource.getFeedData();
      print('✅ [Repository] FeedData received successfully!');
      print('✅ [Repository] Returning FeedData to BLoC');
      return feedData;
    } catch (e, stackTrace) {
      print('❌ [Repository] Error in getFeedData(): $e');
      print('❌ [Repository] Stack trace: $stackTrace');
      throw Exception('Failed to get feed data: $e');
    }
  }
}