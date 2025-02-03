Chatnest

Chatnest is a Flutter-based Group chat application that supports multiple platforms, including Android, iOS, macOS, Linux, Windows, and Web. This project integrates Firebase for authentication and Firestore for real-time data storage.

Getting Started

Prerequisites

* Flutter SDK
*  Dart SDK
* Firebase Account

Installation

1. Clone the repository:

git clone https://github.com/jodahe1/chatnest.git
cd chatnest

2. Install dependencies:

flutter pub get

3. Set up Firebase:
Follow This instructions to set up Firebase for your Flutter project: Firebase Setup (https://firebase.flutter.dev/docs/overview/ )
Add the google-services.json file for Android in app
Add the GoogleService-Info.plist file for iOS in Runner

Running the App
To run the app on a specific platform, use the following commands:

Android:
flutter run
iOS:
flutter run
Web:
flutter run -d chrome
macOS:
flutter run -d macos
Linux:
flutter run -d linux
Windows:
flutter run -d windows


Project Structure
.
├── android/
├── ios/
├── lib/
│   ├── main.dart
│   ├── registration_screen.dart
│   ├── rounded.dart
│   └── ...
├── linux/
├── macos/
├── test/
├── web/
├── windows/
├── pubspec.yaml
└── README.md

Key Files

lib/main.dart: Entry point of the application.
lib/registration_screen.dart: Registration screen implementation.
lib/rounded.dart: Custom rounded button widget.

Dependencies

firebase_auth: "^3.10.1"
cloud_firestore: "^5.6.2"
modal_progress_hud_nsn: "^0.5.1"
flutter_lints: "^4.0.0"

Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes.

License

This project is licensed under the MIT License - see the LICENSE file for details.

Acknowledgments

Flutter
Firebase
For more information, visit the Flutter documentation and the Firebase documentation.

This README file provides an overview of the Chatnest project, including setup instructions, project structure, and key dependencies. For detailed information on each file and function, refer to the source code and comments within the project.