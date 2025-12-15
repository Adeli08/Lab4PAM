import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../data/datasources/remote_data_source.dart';
import '../data/repositories/feed_repository_impl.dart';
import '../domain/repositories/feed_repository.dart';
import '../presentation/bloc/feed_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  print('🔧 [DI] Initializing dependency injection...');
  
  // Bloc
  sl.registerFactory(
    () {
      print('🔧 [DI] Creating FeedBloc instance...');
      return FeedBloc(feedRepository: sl());
    },
  );

  // Repository
  sl.registerLazySingleton<FeedRepository>(
    () {
      print('🔧 [DI] Creating FeedRepositoryImpl instance...');
      return FeedRepositoryImpl(remoteDataSource: sl());
    },
  );

  // Data sources
  sl.registerLazySingleton<RemoteDataSource>(
    () {
      print('🔧 [DI] Creating RemoteDataSourceImpl instance...');
      return RemoteDataSourceImpl(client: sl());
    },
  );

  // External
  sl.registerLazySingleton(() {
    print('🔧 [DI] Creating http.Client instance...');
    return http.Client();
  });
  
  print('✅ [DI] Dependency injection initialized successfully!');
}