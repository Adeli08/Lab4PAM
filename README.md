# Lab 4 - Clean Architecture News Feed

This Flutter project demonstrates Clean Architecture implementation with data loading from a web service and JSON serialization.

## Project Structure

```
lib/
├── core/
│   └── injection_container.dart     # Dependency injection setup using GetIt
├── data/
│   ├── datasources/
│   │   └── remote_data_source.dart  # HTTP API client implementation
│   ├── models/
│   │   ├── feed_data_model.dart     # JSON model for feed data
│   │   ├── news_item_model.dart     # JSON model for news items
│   │   └── user_model.dart          # JSON model for user data
│   └── repositories/
│       └── feed_repository_impl.dart # Repository implementation
├── domain/
│   ├── entities/
│   │   ├── feed_data.dart          # Domain entity for feed data
│   │   ├── news_item.dart          # Domain entity for news items
│   │   └── user.dart               # Domain entity for user
│   └── repositories/
│       └── feed_repository.dart     # Repository interface
└── presentation/
    ├── bloc/
    │   ├── feed_bloc.dart          # BLoC for state management
    │   ├── feed_event.dart         # BLoC events
    │   └── feed_state.dart         # BLoC states
    ├── pages/
    │   └── feed_page.dart          # Main feed page
    └── widgets/
        ├── news_item_widget.dart   # News item UI component
        └── user_profile_widget.dart # User profile UI component
```

## Clean Architecture Layers

### 1. Domain Layer
- **Entities**: Core business objects (User, NewsItem, FeedData)
- **Repositories**: Interfaces defining data access contracts
- **Use Cases**: Business logic (can be added as needed)

### 2. Data Layer
- **Models**: Data transfer objects with JSON serialization
- **Data Sources**: Remote API client implementation
- **Repository Implementations**: Concrete implementations of domain repositories

### 3. Presentation Layer
- **BLoC**: State management using flutter_bloc
- **Pages**: UI screens
- **Widgets**: Reusable UI components

## API Endpoints Used

- **Base URL**: `https://test-api-jlbn.onrender.com/v4`
- **Feed Details**: `/feed/details` - Returns user info, trending news, and recommendations

## Features

- ✅ Clean Architecture separation
- ✅ JSON serialization with `json_annotation` and `json_serializable`
- ✅ HTTP requests using `http` package
- ✅ State management with `flutter_bloc`
- ✅ Dependency injection with `get_it`
- ✅ Network image loading with error handling
- ✅ Pull-to-refresh functionality
- ✅ User profile display with notification count
- ✅ Trending news and recommendations sections
- ✅ Publisher verification badges
- ✅ Follow/Following status for recommendations

## Dependencies

```yaml
dependencies:
  flutter: sdk: flutter
  cupertino_icons: ^1.0.8
  http: ^1.1.0
  json_annotation: ^4.8.1
  flutter_bloc: ^8.1.3
  get_it: ^7.6.4

dev_dependencies:
  flutter_test: sdk: flutter
  flutter_lints: ^5.0.0
  build_runner: ^2.4.7
  json_serializable: ^6.7.1
  mockito: ^5.4.2
```

## How to Run

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Generate JSON serialization code:
   ```bash
   flutter packages pub run build_runner build
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Testing

Run tests to verify JSON serialization and data parsing:
```bash
flutter test
```

## Architecture Benefits

1. **Separation of Concerns**: Each layer has a specific responsibility
2. **Testability**: Easy to unit test each layer independently
3. **Maintainability**: Changes in one layer don't affect others
4. **Scalability**: Easy to add new features following the same patterns
5. **Code Reusability**: Domain entities can be reused across different data sources
