# Flutter Clean Architecture Template

A robust, scalable starter template for Flutter applications built following the principles of **Clean Architecture**.

## 🏗️ Architecture Overview

This project follows Clean Architecture with a clear separation of concerns into three main layers:

```
lib/
├── core/             # Shared utilities, constants, themes, networks, and errors
└── features/         # Modular feature-first architecture
    └── feature_name/
        ├── data/         # Data Sources, Repositories Implementation, Models
        ├── domain/       # Entities, Use Cases, Repository Interfaces
        └── presentation/ # UI Screens, Widgets, State Management (BLoC/Cubit/Provider)
```

### Layers Breakdown

- **Domain Layer**: Contains enterprise business rules, entities, and use cases. Fully decoupled from Flutter UI and third-party frameworks.
- **Data Layer**: Responsible for retrieving and persisting data (REST APIs, Local DBs). Implements repository interfaces defined in the domain layer.
- **Presentation Layer**: UI elements, screens, custom widgets, and state management logic.

## 🚀 Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/MegrurNiftiyev/Flutter-Clean-Arch-Template.git
   cd Flutter-Clean-Arch-Template
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the project:**
   ```bash
   flutter run
   ```

## 📝 License

This project is licensed under the [MIT License](LICENSE).
