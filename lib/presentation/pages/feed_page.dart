import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/feed_bloc.dart';
import '../bloc/feed_event.dart';
import '../bloc/feed_state.dart';
import '../widgets/user_profile_widget.dart';
import '../widgets/news_item_widget.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  void initState() {
    super.initState();
    print('📄 [FeedPage] initState() called');
    print('📄 [FeedPage] Dispatching LoadFeedEvent...');
    context.read<FeedBloc>().add(LoadFeedEvent());
    print('📄 [FeedPage] LoadFeedEvent dispatched');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Feed'),
        backgroundColor: Colors.white,
        elevation: 1,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          print('📄 [FeedPage] BlocBuilder rebuilding with state: ${state.runtimeType}');
          
          if (state is FeedLoading) {
            print('⏳ [FeedPage] Rendering FeedLoading state');
            return const Center(child: CircularProgressIndicator());
          } else if (state is FeedLoaded) {
            print('✅ [FeedPage] Rendering FeedLoaded state');
            print('✅ [FeedPage] User: ${state.feedData.user.name}');
            print('✅ [FeedPage] Trending News: ${state.feedData.trendingNews.length} items');
            print('✅ [FeedPage] Recommendations: ${state.feedData.recommendations.length} items');
            return RefreshIndicator(
              onRefresh: () async {
                print('🔄 [FeedPage] Pull-to-refresh triggered');
                print('🔄 [FeedPage] Dispatching LoadFeedEvent...');
                context.read<FeedBloc>().add(LoadFeedEvent());
                print('🔄 [FeedPage] LoadFeedEvent dispatched from refresh');
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserProfileWidget(user: state.feedData.user),
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Trending News',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...state.feedData.trendingNews.map(
                      (news) => NewsItemWidget(newsItem: news),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Recommendations',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...state.feedData.recommendations.map(
                      (news) => NewsItemWidget(newsItem: news),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          } else if (state is FeedError) {
            print('❌ [FeedPage] Rendering FeedError state');
            print('❌ [FeedPage] Error message: ${state.message}');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      print('🔄 [FeedPage] Retry button pressed');
                      print('🔄 [FeedPage] Dispatching LoadFeedEvent again...');
                      context.read<FeedBloc>().add(LoadFeedEvent());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          print('ℹ️ [FeedPage] Rendering initial state (FeedInitial)');
          return const Center(child: Text('Welcome to News Feed'));
        },
      ),
    );
  }
}