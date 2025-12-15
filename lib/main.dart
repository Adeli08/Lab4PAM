import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/injection_container.dart' as di;
import 'presentation/bloc/feed_bloc.dart';
import 'presentation/pages/feed_page.dart';

void main() async {
  print('🚀 [MAIN] Application starting...');
  print('🚀 [MAIN] Initializing WidgetsFlutterBinding...');
  WidgetsFlutterBinding.ensureInitialized();
  
  print('🚀 [MAIN] Initializing dependency injection...');
  await di.init();
  
  print('🚀 [MAIN] Running MyApp...');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('📱 [MyApp] Building MaterialApp...');
    print('📱 [MyApp] Creating FeedBloc from GetIt...');
    return MaterialApp(
      title: 'Clean Architecture News Feed',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) {
          print('📱 [MyApp] BlocProvider create() called');
          final bloc = di.sl<FeedBloc>();
          print('📱 [MyApp] FeedBloc instance created');
          return bloc;
        },
        child: const FeedPage(),
      ),
    );
  }
}
