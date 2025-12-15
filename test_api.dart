import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  try {
    print('🔄 Testing API connection...');
    
    final client = http.Client();
    final response = await client.get(
      Uri.parse('https://test-api-jlbn.onrender.com/v4/feed/details'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print('📡 Response Status: ${response.statusCode}');
    
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print('✅ API Response successful!');
      print('📄 Raw response: ${response.body}');
      
      // Check the actual structure
      print('\n🔍 JSON Keys: ${jsonData.keys}');
      
      if (jsonData.containsKey('user') && jsonData['user'] != null) {
        print('👤 User: ${jsonData['user']['name']}');
        print('User keys: ${jsonData['user'].keys}');
      } else {
        print('❌ No user data found');
      }
      
      if (jsonData.containsKey('trending_news')) {
        print('📰 Trending News: ${jsonData['trending_news']?.length ?? 0} articles');
      }
      
      if (jsonData.containsKey('recommendations')) {
        print('💡 Recommendations: ${jsonData['recommendations']?.length ?? 0} articles');
      }
    } else {
      print('❌ API Error: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    
    client.close();
  } catch (e) {
    print('❌ Error testing API: $e');
  }
}