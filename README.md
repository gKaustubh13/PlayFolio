# PlayFolio

A Flutter application for discovering and exploring video games using the IGDB API. Features Firebase authentication and a modern dark theme interface.

## Features

- **User Authentication**: Email/password registration and login with Firebase
- **Anonymous Access**: Browse games as a guest user
- **Game Discovery**: Search and browse games from IGDB database
- **Game Details**: View comprehensive information including ratings, screenshots, genres, and platforms
- **Responsive UI**: Modern dark theme with cached network images
- **Real-time Search**: Debounced search with pagination

## Architecture

The project uses clean architecture with Riverpod for state management:

```
lib/
├── application.dart              # App configuration
├── main.dart                    # Entry point
├── core/
│   └── providers.dart           # Global providers
└── features/
    ├── auth/                    # Authentication
    │   ├── models/             # User and request models
    │   ├── repositories/       # Auth repository
    │   ├── services/           # Firebase auth services
    │   ├── view/               # Login/register screens
    │   └── view_model/         # Auth state management
    ├── games/                   # Games functionality
    │   ├── models/             # Game models
    │   ├── repositories/       # Games repository
    │   ├── services/           # IGDB API service
    │   ├── view/               # Game screens
    │   └── view_model/         # Games state management
    └── home/                    # Home screen
        ├── views/              # Home and game list UI
        └── view_model/         # Home logic
```

## Dependencies

### Core
- **flutter_riverpod**: State management
- **firebase_core**: Firebase initialization
- **firebase_auth**: User authentication
- **cloud_firestore**: User data storage
- **dio**: HTTP client for API calls
- **flutter_dotenv**: Environment variables

### UI
- **cached_network_image**: Image caching and loading
- **cupertino_icons**: iOS-style icons

## Usage

1. **Authentication**: Register with email/password or continue as guest
2. **Browse Games**: Scroll through the game grid on the home screen
3. **Search**: Use the search bar to find specific games
4. **Game Details**: Tap any game card to view detailed information
5. **Pagination**: Scroll to automatically load more games

## API Integration

The app integrates with the IGDB (Internet Game Database) API to fetch:
- Game listings with cover images and ratings
- Detailed game information including summaries, genres, platforms, and screenshots
- Search functionality across the game database

## Firebase Services

- **Authentication**: Email/password and anonymous sign-in
- **Firestore**: User profile storage
- **Multi-platform**: Configured for Android, iOS, Web, Windows, and macOS
