# 🐱 PetFinder App

A beautiful Flutter application for discovering and favoriting pets using The Cat API. Built with clean architecture, MVVM pattern, and comprehensive testing.

## ✨ Features

### Core Features
- **View Pets**: Browse through a collection of adorable cats
- **Search & Filter**: Find pets by specific breeds
- **Favorites**: Save your favorite pets locally
- **Pet Details**: View detailed information about each pet
- **Smooth Onboarding**: First-time user experience

### Technical Features
- Clean Architecture with MVVM
- State Management using Cubit (Bloc)
- Navigation with GoRouter
- Offline favorites with SharedPreferences
- Image caching
- Comprehensive testing (Unit, Widget, Integration)

## 📱 Screenshots

```
[Splash Screen] -> [Onboarding] -> [Home Screen] -> [Details] -> [Favorites]
```

## 🛠️ Tech Stack

- **Framework**: Flutter 3.0+
- **State Management**: flutter_bloc (Cubit)
- **Navigation**: go_router
- **Network**: dio, retrofit
- **Local Storage**: shared_preferences
- **Image Caching**: cached_network_image
- **Testing**: flutter_test, bloc_test, mocktail, integration_test

## 📋 Prerequisites

- Flutter SDK 3.0 or higher
- Dart 3.0 or higher
- An API key from [The Cat API](https://thecatapi.com/)

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/AhmedBnSamy/pet_finder_app
cd petfinder_app
```

### 2. Get Dependencies

```bash
flutter pub get
```

### 3. Get Your API Key

1. Visit [https://thecatapi.com/signup](https://thecatapi.com/signup)
2. Enter your email address
3. Check your email for the API key
4. Copy the API key

### 4. Add API Key

Open `lib/core/constants/api_constants.dart` and replace `YOUR_API_KEY_HERE` with your actual API key:

```dart
static const String apiKey = 'live_fGv9ELcaHZHXtFJ9IpqYdm3mf5JrAInzeYi1cXNglNGDMauAGpwaxbG66PtK9FRx'; // Your API key here
```

### 5. Generate Code

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 6. Run the App

```bash
flutter run
```

## 🏗️ Project Structure

```
lib/
├── main.dart                     # App entry point
├── app.dart                      # App configuration
├── core/                         # Core utilities
│   ├── constants/               # API constants, colors
│   ├── network/                 # API service, Dio setup
│   └── utils/                   # Helper utilities
├── features/                     # Feature modules
│   ├── splash/                  # Splash screen
│   ├── onboarding/              # Onboarding flow
│   ├── home/                    # Home screen with pet list
│   │   ├── data/               # Data layer
│   │   │   ├── models/        # Data models
│   │   │   ├── datasources/   # API data sources
│   │   │   └── repositories/  # Repository implementations
│   │   ├── domain/             # Business logic
│   │   │   ├── entities/      # Domain entities
│   │   │   └── repositories/  # Repository interfaces
│   │   └── presentation/       # UI layer
│   │       ├── cubit/         # State management
│   │       ├── pages/         # Screens
│   │       └── widgets/       # Reusable widgets
│   ├── details/                # Pet details screen
│   └── favorites/              # Favorites feature
└── config/                      # App configuration
    └── routes/                 # Navigation routes
```

## 🧪 Testing

### Run All Tests

```bash
flutter test
```

### Run Unit Tests

```bash
flutter test test/unit/
```

### Run Widget Tests

```bash
flutter test test/widget/
```

### Run Integration Tests

```bash
flutter test integration_test/
```

## 🔄 Git Workflow

### Branch Strategy

```
main (production)
  └── develop (development)
        ├── feature/splash-screen
        ├── feature/home-screen
        ├── feature/favorites
        └── feature/testing
```

### Commit Message Convention

```
feat: Add splash screen animation
fix: Fix favorite button state
test: Add unit tests for PetCubit
docs: Update README with setup instructions
refactor: Improve repository structure
```

### Example Workflow

```bash
# Create a new feature branch
git checkout -b feature/home-screen

# Make changes and commit
git add .
git commit -m "feat: Implement home screen with pet grid"

# Push to remote
git push origin feature/home-screen

# Create Pull Request on GitHub
# After review, merge to develop
```

## 📊 Test Results

### Unit Tests
- ✅ PetCubit tests (5/5 passed)
- ✅ FavoritesCubit tests (4/4 passed)
- ✅ Repository tests (3/3 passed)

### Widget Tests
- ✅ PetCard widget (4/4 passed)
- ✅ HomeScreen widget (3/3 passed)

### Integration Tests
- ✅ Complete user flow (1/1 passed)
- ✅ Favorites flow (1/1 passed)

**Total: 21/21 tests passing ✅**

## 🌐 API Documentation

### Endpoints Used

`

## 🐛 Troubleshooting

### API Key Issues
- Make sure you've added your API key in `api_constants.dart`
- Check that your API key is valid and active

### Build Runner Issues
```bash
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### Dependency Issues
```bash
flutter clean
flutter pub get
```

## 📝 Additional Notes

### Code Quality
- Follow Flutter/Dart style guide
- Use meaningful variable names
- Write clear commit messages
- Add comments for complex logic
- Keep functions small and focused

### Testing Best Practices
- Write tests before or during development
- Test the happy path first
- Cover edge cases
- Use descriptive test names
- Mock external dependencies

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📄 License

This project is created for educational purposes.

## 👨‍💻 Author

Your Name - [GitHub](https://github.com/AhmedBnSamy)

## 🙏 Acknowledgments

- [The Cat API](https://thecatapi.com/) for providing the pet data
- Flutter team for the amazing framework
- Bloc library for state management

---

**Happy Coding! 🚀**