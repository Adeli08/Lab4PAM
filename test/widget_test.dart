// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';

import 'package:lab4_clean_architecture/presentation/bloc/feed_bloc.dart';
import 'package:lab4_clean_architecture/presentation/pages/feed_page.dart';
import 'package:lab4_clean_architecture/domain/repositories/feed_repository.dart';

class MockFeedRepository extends Mock implements FeedRepository {}

void main() {
  testWidgets('Feed page widget test', (WidgetTester tester) async {
    final mockRepository = MockFeedRepository();

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => FeedBloc(feedRepository: mockRepository),
          child: const FeedPage(),
        ),
      ),
    );

    // Verify that our feed page loads
    expect(find.text('News Feed'), findsOneWidget);
    expect(find.text('Welcome to News Feed'), findsOneWidget);
  });
}
