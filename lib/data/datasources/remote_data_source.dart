import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../models/feed_data_model.dart';

abstract class RemoteDataSource {
  Future<FeedDataModel> getFeedData();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  static const String baseUrl = 'https://test-api-jlbn.onrender.com/v4';

  RemoteDataSourceImpl({required this.client});

  @override
  Future<FeedDataModel> getFeedData() async {
    final url = '$baseUrl/feed/details';
    print('🌐 [RemoteDataSource] Making GET request to: $url');
    print('🌐 [RemoteDataSource] Headers: {Content-Type: application/json}');
    print('⏱️ [RemoteDataSource] Starting request at: ${DateTime.now()}');
    
    try {
      print('⏱️ [RemoteDataSource] Calling client.get()...');
      final stopwatch = Stopwatch()..start();
      
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          stopwatch.stop();
          print('⏱️ [RemoteDataSource] Request timed out after ${stopwatch.elapsedMilliseconds}ms');
          throw Exception('Request timeout after 10 seconds');
        },
      );

      stopwatch.stop();
      print('📡 [RemoteDataSource] Response received after ${stopwatch.elapsedMilliseconds}ms!');
      print('📡 [RemoteDataSource] Status Code: ${response.statusCode}');
      print('📡 [RemoteDataSource] Response Body Length: ${response.body.length} bytes');
      
      if (response.body.length < 500) {
        print('📡 [RemoteDataSource] Response Body Preview: ${response.body}');
      } else {
        print('📡 [RemoteDataSource] Response Body Preview (first 500 chars): ${response.body.substring(0, 500)}...');
      }
      
      if (response.statusCode == 200) {
        print('✅ [RemoteDataSource] Status 200 - Parsing JSON...');
        final jsonData = json.decode(response.body);
        print('📦 [RemoteDataSource] JSON decoded successfully');
        print('📦 [RemoteDataSource] JSON keys: ${jsonData.keys.toList()}');
        
        try {
          final feedDataModel = FeedDataModel.fromJson(jsonData);
          print('✅ [RemoteDataSource] FeedDataModel created successfully!');
          print('✅ [RemoteDataSource] User: ${feedDataModel.user.name}');
          print('✅ [RemoteDataSource] Trending News Count: ${feedDataModel.trendingNews.length}');
          print('✅ [RemoteDataSource] Recommendations Count: ${feedDataModel.recommendations.length}');
          return feedDataModel;
        } catch (e, stackTrace) {
          print('❌ [RemoteDataSource] Error parsing FeedDataModel: $e');
          print('❌ [RemoteDataSource] Stack trace: $stackTrace');
          rethrow;
        }
      } else {
        print('❌ [RemoteDataSource] Failed with status code: ${response.statusCode}');
        print('❌ [RemoteDataSource] Response body: ${response.body}');
        throw Exception('Failed to load feed data: Status ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      print('❌ [RemoteDataSource] Exception occurred: $e');
      print('❌ [RemoteDataSource] Stack trace: $stackTrace');
      print('🔄 [RemoteDataSource] Attempting fallback to local feed.json...');
      
      // Fallback to local feed.json if API is not accessible
      try {
        final String jsonString = await rootBundle.loadString('assets/feed.json');
        print('✅ [RemoteDataSource] Loaded assets/feed.json from assets');
        final jsonData = json.decode(jsonString);
        print('✅ [RemoteDataSource] Parsed local JSON successfully');
        
        final feedDataModel = FeedDataModel.fromJson(jsonData);
        print('✅ [RemoteDataSource] FeedDataModel created from local file!');
        print('✅ [RemoteDataSource] User: ${feedDataModel.user.name}');
        print('✅ [RemoteDataSource] Trending News Count: ${feedDataModel.trendingNews.length}');
        print('✅ [RemoteDataSource] Recommendations Count: ${feedDataModel.recommendations.length}');
        return feedDataModel;
      } catch (fallbackError, fallbackStack) {
        print('❌ [RemoteDataSource] Fallback also failed: $fallbackError');
        print('❌ [RemoteDataSource] Fallback stack trace: $fallbackStack');
        rethrow;
      }
    }
  }
}