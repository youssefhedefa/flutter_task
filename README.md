# Flutter E-Commerce App

A modern Flutter e-commerce application built with clean architecture, featuring product browsing, search functionality, wishlist management, and user authentication.

## 📋 Table of Contents

- [Features](#features)
- [API Choice](#api-choice)
- [State Management](#state-management)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Setup & Installation](#setup--installation)
- [Running the App](#running-the-app)
- [Project Structure](#project-structure)
- [Dependencies](#dependencies)

## ✨ Features

- **Authentication**: User login with secure token storage
- **Home Screen**: Browse products by categories with caching
- **Product Details**: Detailed product information with carousel images
- **Search**: Real-time product search with debouncing
- **Wishlist**: Add/remove products to favorites with persistence
- **Offline Support**: Local caching using Hive for offline access
- **Bottom Navigation**: Smooth navigation between main sections

## 🌐 API Choice

### FakeStore API
**Base URL**: `https://fakestoreapi.com/`

**Why FakeStore API?**
- ✅ Free and open-source REST API
- ✅ No authentication required for product data
- ✅ Comprehensive product catalog with real-world data structure
- ✅ Supports categories, product details, and authentication endpoints
- ✅ Reliable uptime and fast response times
- ✅ Perfect for prototyping and testing e-commerce applications

**Endpoints Used:**
```
POST /auth/login              - User authentication
GET  /products                - Get all products
GET  /products/categories     - Get product categories
GET  /products/category/:cat  - Get products by category
GET  /products/:id            - Get product details
```

**API Documentation**: [https://fakestoreapi.com/docs](https://fakestoreapi.com/docs)

## 🎯 State Management

### BLoC (Business Logic Component) Pattern

This app uses **flutter_bloc** (v8.1.6) for state management, following the BLoC pattern for predictable state management and separation of concerns.

#### Why BLoC?

- ✅ **Separation of Concerns**: Business logic is completely separated from UI
- ✅ **Testability**: Easy to test business logic independently
- ✅ **Reusability**: BLoCs can be reused across different parts of the app
- ✅ **Reactive**: Stream-based architecture for reactive programming
- ✅ **Scalability**: Well-suited for large applications

#### BLoC Implementation in the App

**Cubits Used:**
- `LoginCubit` - Manages authentication state
- `SplashCubit` - Handles initial app loading and auth check
- `HomeCubit` - Manages home screen state (products, categories)
- `ProductDetailsCubit` - Handles product details loading
- `MainNavigationCubit` - Controls bottom navigation state

**BLoCs Used:**
- `SearchBloc` - Manages search functionality with events and states

**State Types:**
- Initial State
- Loading State
- Success State (with data)
- Error State (with error message)

**Example Structure:**
```dart
// Event
class SearchProducts extends SearchEvent {
  final String query;
}

// State
class SearchLoading extends SearchState {}
class SearchSuccess extends SearchState {
  final List<ProductEntity> products;
}

// BLoC
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  // Business logic here
}
```

## 🏗️ Architecture

### Clean Architecture

The app follows **Clean Architecture** principles with clear separation of layers:

```
lib/
├── core/                    # Core utilities and shared code
│   ├── constants/          # App constants and strings
│   ├── networking/         # API and storage services
│   ├── routing/            # App navigation
│   ├── theming/            # Theme configuration
│   ├── utilities/          # Helper functions
│   └── widgets/            # Reusable widgets
├── features/               # Feature modules
│   ├── auth/
│   │   ├── data/          # Data sources, repositories
│   │   ├── domain/        # Entities, repositories, use cases
│   │   └── presentation/  # UI, BLoC/Cubit
│   ├── home/
│   ├── product_details/
│   ├── search/
│   ├── wishlist/
│   └── ...
└── main.dart              # App entry point
```

**Layer Responsibilities:**

1. **Presentation Layer**
   - UI widgets and screens
   - BLoC/Cubit for state management
   - User interaction handling

2. **Domain Layer**
   - Business entities
   - Repository interfaces
   - Use cases (business logic)

3. **Data Layer**
   - Repository implementations
   - Data sources (remote API, local storage)
   - Data models and mappers

**Key Patterns:**
- Repository Pattern
- Dependency Injection (GetIt)
- Mapper Pattern (DTO to Entity conversion)
- Use Case Pattern (single responsibility)

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK**: 3.8.1 or higher
  - Download from [flutter.dev](https://flutter.dev/docs/get-started/install)
- **Dart SDK**: 3.8.1 or higher (included with Flutter)
- **IDE**: Android Studio, VS Code, or IntelliJ IDEA
- **Platform-specific tools**:
  - **Android**: Android Studio with Android SDK
  - **iOS**: Xcode (macOS only)
- **Git**: For version control

**Verify Installation:**
```bash
flutter doctor
```

## 🚀 Setup & Installation

### 1. Clone the Repository
```bash
git clone <repository-url>
cd flutter_task
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Generate Required Files (if needed)
```bash
# If using build_runner for code generation
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Configure Platform-Specific Settings

#### Android
No additional configuration required.

#### iOS (macOS only)
```bash
cd ios
pod install
cd ..
```

## ▶️ Running the App

### Run on Connected Device/Emulator

**Debug Mode:**
```bash
flutter run
```

**Release Mode:**
```bash
flutter run --release
```

**Specific Device:**
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>
```

### Run on Specific Platforms

**Android:**
```bash
flutter run -d android
```

**iOS (macOS only):**
```bash
flutter run -d ios
```

**Chrome (Web):**
```bash
flutter run -d chrome
```

### Build APK/IPA

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle:**
```bash
flutter build appbundle --release
```

**iOS (macOS only):**
```bash
flutter build ios --release
```

## 📁 Project Structure

```
flutter_task/
├── android/                 # Android native code
├── ios/                     # iOS native code
├── lib/
│   ├── app/                # App initialization
│   │   ├── flutter_task_app.dart
│   │   └── init_services.dart
│   ├── core/
│   │   ├── constants/      # App-wide constants
│   │   ├── networking/     # API & storage services
│   │   │   ├── remote/    # HTTP client (Dio)
│   │   │   ├── storage/   # Local storage (Hive)
│   │   │   └── exceptions/
│   │   ├── routing/        # Navigation setup
│   │   ├── theming/        # App theme
│   │   ├── utilities/      # Service locator, helpers
│   │   └── widgets/        # Shared widgets
│   ├── features/
│   │   ├── auth/          # Authentication feature
│   │   ├── home/          # Home screen feature
│   │   ├── product_details/
│   │   ├── search/
│   │   ├── wishlist/
│   │   ├── splash/
│   │   └── main_navigation/
│   ├── generated/         # Auto-generated files
│   └── main.dart
├── assets/                # Images, icons, fonts
├── test/                  # Unit & widget tests
├── pubspec.yaml          # Dependencies
└── README.md
```

## 📦 Dependencies

### Core Dependencies
- **flutter_bloc** (^8.1.6) - State management
- **get_it** (^9.1.1) - Dependency injection
- **equatable** (^2.0.7) - Value equality

### Networking
- **dio** (^5.9.0) - HTTP client

### Local Storage
- **hive** (^2.2.3) - NoSQL database
- **hive_flutter** (^1.1.0) - Hive Flutter integration
- **crypto** (^3.0.5) - Encryption utilities

### UI Components
- **flutter_svg** (^2.2.3) - SVG rendering
- **cached_network_image** (^3.4.1) - Image caching
- **carousel_slider** (^5.1.1) - Image carousel
- **skeletonizer** (^2.1.1) - Loading skeletons

### Utilities
- **stream_transform** (^2.1.0) - Stream utilities

## 📱 Demo Credentials

For testing the login functionality, use the FakeStore API test credentials:

```
Username: mor_2314
Password: 83r5^_
```

Or any valid credentials from the [FakeStore API users](https://fakestoreapi.com/users).

## 🔧 Configuration

### API Configuration
The base URL is configured in:
```dart
lib/core/networking/remote/api_routes.dart
```

### Theme Configuration
App theme is configured in:
```dart
lib/core/theming/app_theme.dart
```

### Service Locator
Dependency injection setup is in:
```dart
lib/core/utilities/service_locator.dart
```

## 🐛 Troubleshooting

### Common Issues

**1. Dependency Issues**
```bash
flutter clean
flutter pub get
```

**2. Build Issues**
```bash
flutter clean
cd android && ./gradlew clean
cd ..
flutter run
```

**3. iOS Pod Issues**
```bash
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
```

**4. Hive Storage Issues**
```bash
# Clear app data from device/emulator
flutter clean
```

## 📄 License

This project is for educational purposes.

## 👥 Contributing

Contributions, issues, and feature requests are welcome!

## 📞 Support

For support, please open an issue in the repository.

---

**Built with ❤️ using Flutter**
