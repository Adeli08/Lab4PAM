import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../lib/data/datasources/remote_data_source.dart';
import '../lib/data/models/feed_data_model.dart';

// Mock HTTP Client
class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('Remote Data Source Tests', () {
    late RemoteDataSourceImpl dataSource;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      dataSource = RemoteDataSourceImpl(client: mockHttpClient);
    });

    test('should parse JSON response correctly', () {
      // Sample JSON response from the API
      const jsonResponse = '''
      {
        "user": {
          "name": "Tyler",
          "profile_image": "https://randomuser.me/api/portraits/men/85.jpg",
          "notification_count": 3
        },
        "trending_news": [
          {
            "id": 1,
            "category": "Environment",
            "title": "Global Summit on Climate Change",
            "publisher": "BBC News",
            "publisher_icon": "https://example.com/bbc.jpg",
            "image": "https://example.com/image.jpg",
            "date": "Jun 9, 2023",
            "is_verified": true
          }
        ],
        "recommendations": [
          {
            "id": 101,
            "publisher": "Forbes",
            "publisher_icon": "https://example.com/forbes.svg",
            "publisher_verified": true,
            "date": "Jun 11, 2023",
            "title": "Tech Startup Secures Funding",
            "category": "Business",
            "is_following": false,
            "image": "https://example.com/tech.jpg",
            "is_verified": true
          }
        ]
      }
      ''';

      // Test JSON parsing
      final Map<String, dynamic> jsonMap = {
        "user": {
          "name": "Tyler",
          "profile_image": "https://randomuser.me/api/portraits/men/85.jpg",
          "notification_count": 3
        },
        "trending_news": [
          {
            "id": 1,
            "category": "Environment",
            "title": "Global Summit on Climate Change",
            "publisher": "BBC News",
            "publisher_icon": "https://example.com/bbc.jpg",
            "image": "https://example.com/image.jpg",
            "date": "Jun 9, 2023",
            "is_verified": true
          }
        ],
        "recommendations": [
          {
            "id": 101,
            "publisher": "Forbes",
            "publisher_icon": "https://example.com/forbes.svg",
            "publisher_verified": true,
            "date": "Jun 11, 2023",
            "title": "Tech Startup Secures Funding",
            "category": "Business",
            "is_following": false,
            "image": "https://example.com/tech.jpg",
            "is_verified": true
          }
        ]
      };

      final feedData = FeedDataModel.fromJson(jsonMap);

      // Verify parsing
      expect(feedData.user.name, equals('Tyler'));
      expect(feedData.user.notificationCount, equals(3));
      expect(feedData.trendingNews.length, equals(1));
      expect(feedData.recommendations.length, equals(1));
      expect(feedData.trendingNews.first.title, equals('Global Summit on Climate Change'));
      expect(feedData.recommendations.first.isFollowing, equals(false));
    });
  });
}