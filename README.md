# Flutter Google Authentication and CRUD Operations with Cloud Firestore

This Flutter project demonstrates how to implement Google Authentication and perform CRUD (Create, Read, Update, Delete) operations using Cloud Firestore in a Flutter application. With this implementation, users can sign in with their Google account and manage tasks in a Cloud Firestore database.

## Prerequisites

Before you begin, ensure you have the following set up:

- Flutter development environment
- A Firebase project with enabled Google Authentication and Cloud Firestore

## Getting Started

1. Clone the repository to your local machine:

```bash
git clone <repository_url>
```

2. Add the necessary Firebase configuration files:

   - For Android: Place the `google-services.json` file in the `android/app` directory.
   - For iOS: Place the `GoogleService-Info.plist` file in the `ios/Runner` directory.

3. Run the following command to install the required dependencies:

```bash
flutter pub get
```

4. Launch the app on your emulator or physical device:

```bash
flutter run
```

## Google Authentication

The app provides a seamless Google sign-in experience. Users can sign in by tapping the "Sign in with Google" button on the AuthScreen. If they are already signed in, the app will redirect to the task management screen directly.

## Task Management

The task management screen displays a list of tasks retrieved from Cloud Firestore. Users can perform the following operations:

- **Create Task:** Tap the floating action button, enter the task details, and tap the "Create" button to add a new task.
- **Read Tasks:** The list of tasks is updated in real-time as changes occur in the database.
- **Update Task:** Tap on a task to edit its title, description, or completion status. Make the necessary changes and tap "Save" to update the task.
- **Delete Task:** Swipe left on a task to reveal the delete button. Tap it to remove the task from the list and Cloud Firestore.

## Firebase Configuration

To use this project with your own Firebase project, follow these steps:

1. Create a Firebase project at the [Firebase Console](https://console.firebase.google.com/).
2. Enable Google Authentication in the "Authentication" section.
3. Set up Cloud Firestore in the "Database" section.

## Project Structure

The project is structured as follows:

- `lib/`: Contains the main Dart code.
  - `main.dart`: Entry point of the app, initializes Firebase and routes to the appropriate screens.
  - `auth_screen.dart`: The screen where users sign in with Google.
  - `task_list_screen.dart`: The main screen where users manage tasks.
  - `services/`: Contains the utility classes for Google Authentication and Cloud Firestore operations.
    - `auth_service.dart`: Manages Google sign-in and sign-out operations.
    - `database_service.dart`: Handles CRUD operations with Cloud Firestore.

## Dependencies

- [firebase_core](https://pub.dev/packages/firebase_core): The FlutterFire plugin to initialize Firebase.
- [firebase_auth](https://pub.dev/packages/firebase_auth): For Google Authentication.
- [cloud_firestore](https://pub.dev/packages/cloud_firestore): To interact with Cloud Firestore.
- [google_sign_in](https://pub.dev/packages/google_sign_in): For Google Sign-In functionality.

## Acknowledgments

This project was inspired by the need for a practical example of Google Authentication and Cloud Firestore integration in a Flutter app. It can serve as a starting point for building more complex applications that require user authentication and cloud-based data storage.

## Contributing

Contributions to this project are welcome. If you encounter any issues or have suggestions for improvements, please submit a pull request or create an issue in the repository.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
