# Awesome Todo App

## Introduction

Welcome to the **Awesome Todo App**! This app is designed to help users manage their tasks with an intuitive interface and support for multiple languages. It leverages modern Flutter practices for state management, local storage, and localization, making it scalable and easy to maintain.

The app provides a robust and simple solution for task management with a clean design and the ability to add and manage tasks effortlessly. The app also supports multiple languages using the `flutter_localizations` package, making it easily adaptable for international users.

## Features

- **Task Management**: Users can create, edit, and delete tasks.
- **Localization**: The app supports multiple languages and can easily be extended with more.
- **Local Storage**: Tasks are stored locally on the device using `drift_flutter`.
- **State Management**: We use `Riverpod` for managing app states in a predictable and scalable manner.
- **Unit Testing**: Unit tests have been implemented for business logic in `test/repository_test.dart`.

## Prerequisites

Before running the app, ensure that you have the following installed:

- **Flutter 3.24.1**: [Flutter installation guide](https://flutter.dev/docs/get-started/install)
- **Dart**: Dart is included with Flutter, but you can find more details [here](https://dart.dev/get-dart)

## Getting Started

Follow the steps below to get your development environment set up and run the app locally:

1. **Clone the repository**:

   Begin by cloning the repository to your local machine:

   ```bash
   git clone https://github.com/gbmarcos/awesome_todo_app.git
   cd awesome-todo-app

2. **Install dependencies**:

   Install the necessary dependencies for the project:

   ```bash
   flutter pub get

3. **Run the app**:

   Now, you can run the app on your connected device or emulator:

   ```bash
   flutter run

4. **Run unit tests**:

   To ensure everything is working as expected, you can run the unit tests defined in the project using:

   ```bash
   flutter test

# Key Technologies & Folder Structure

## Key Technologies

### 1. Flutter 3.24.1

The app is built using the latest stable version of Flutter to ensure high performance and a modern development experience.

### 2. Riverpod for State Management

State management is handled using **Riverpod**, a flexible and powerful state management library that makes it easier to manage app states in a scalable way.

- The state of tasks is managed globally, and components are notified of changes automatically.

### 3. drift_flutter for Local Storage

We use **drift_flutter** for local database management, allowing the app to store tasks locally on the device. This provides persistence even when the app is closed and reopened.

- Tasks are stored in a **SQLite** database.
- The app supports **CRUD** (Create, Read, Update, Delete) operations on tasks.

### 4. flutter_localizations for Multilingual Support

The app supports multiple languages via the **flutter_localizations** package. We are able to easily add more languages by extending the `AppLocalizations` class and updating the `supportedLocales`.

## Folder Structure

- **lib/src/features/todo**: Contains the Todo app features, including the `TodoPage`, business logic, and data models.
- **lib/resources/l10n**: Manages localization files, including different language translations.
- **lib/main.dart**: The entry point of the app, where the `MaterialApp` is defined with all configurations.
- **test/repository_test.dart**: Contains unit tests that validate the core business logic related to the tasks repository.


### Key Additions:
- **Unit Tests**: Mentioned that unit tests are implemented in `test/repository_test.dart` to cover the repository logic.
- **Test Instructions**: Added instructions to run tests with `flutter test`.

This README now provides a comprehensive guide to set up, run, and contribute to the project, along with the inclusion of unit tests.


