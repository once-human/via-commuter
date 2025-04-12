via_commuter/
├── android/
├── build/
├── ios/
├── lib/
│   ├── app/
│   │   └── router.dart          # GoRouter configuration
│   ├── core/
│   │   ├── constants/           # Application constants (e.g., strings, URLs)
│   │   ├── error/               # Error handling (failures, exceptions)
│   │   ├── themes/              # Theme definitions (e.g., light/dark)
│   │   └── usecases/            # Business logic interfaces
│   ├── data/
│   │   ├── datasources/         # Remote/local data sources (APIs, DB)
│   │   ├── models/              # Data models (DTOs)
│   │   └── repositories/        # Repository implementations
│   ├── domain/
│   │   ├── entities/            # Core business entities
│   │   ├── repositories/        # Repository interfaces
│   │   └── usecases/            # Business logic implementations
│   ├── presentation/
│   │   ├── providers/           # State management (Riverpod, Bloc, etc.)
│   │   ├── screens/
│   │   │   ├── home_screen.dart       # Home screen UI
│   │   │   └── onboarding_screen.dart # Onboarding screen UI
│   │   └── widgets/
│   │       ├── bottom_navbar.dart   # Custom bottom navigation bar
│   │       └── ...                # Other shared widgets
│   └── main.dart              # App entry point, theme setup
├── test/
├── analysis_options.yaml
├── pubspec.lock
├── pubspec.yaml
├── README.md
└── project_structure.md     # This file
```

### Description:

*   **`android/`, `ios/`, `web/`, `windows/`, `macos/`, `linux/`**: Platform-specific code.
*   **`build/`**: Output directory for build artifacts.
*   **`lib/`**: Main Dart code for the application.
    *   **`app/`**: Application-level configuration (routing, dependency injection setup).
    *   **`core/`**: Shared utilities, constants, themes, and base classes.
    *   **`data/`**: Data layer - implementation details for fetching and storing data.
    *   **`domain/`**: Domain layer - core business logic, entities, and interfaces (independent of UI and data fetching).
    *   **`presentation/`**: UI layer - screens, widgets, and state management.
        *   **`screens/`**: Individual screen widgets (now flatter).
        *   **`widgets/`**: Reusable UI components shared across screens.
    *   **`main.dart`**: The starting point of the application.
*   **`test/`**: Unit and widget tests.
*   **`pubspec.yaml`**: Project metadata and dependencies.
*   **`README.md`**: Project overview.
*   **`project_structure.md`**: This file outlining the structure. 