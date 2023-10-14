// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCg2yPSoIUts3ZFKOMnC_RFckcCE7IsrBE',
    appId: '1:978968848844:web:00ae502bea4a8a8da8d569',
    messagingSenderId: '978968848844',
    projectId: 'hopper-19606',
    authDomain: 'hopper-19606.firebaseapp.com',
    storageBucket: 'hopper-19606.appspot.com',
    measurementId: 'G-T6WSECDYHB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAb1LXTAe0v16nEu_JE_u2AfB69bomqcAg',
    appId: '1:978968848844:android:3c0800f6b34c261ea8d569',
    messagingSenderId: '978968848844',
    projectId: 'hopper-19606',
    storageBucket: 'hopper-19606.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCJZV8AJaa27AiZAJCPVXfHn8-nMf9DjFQ',
    appId: '1:978968848844:ios:3653d618f04a4aa5a8d569',
    messagingSenderId: '978968848844',
    projectId: 'hopper-19606',
    storageBucket: 'hopper-19606.appspot.com',
    iosBundleId: 'com.example.hopper',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCJZV8AJaa27AiZAJCPVXfHn8-nMf9DjFQ',
    appId: '1:978968848844:ios:a925cfffbb9f87b4a8d569',
    messagingSenderId: '978968848844',
    projectId: 'hopper-19606',
    storageBucket: 'hopper-19606.appspot.com',
    iosBundleId: 'com.example.hopper.RunnerTests',
  );
}
