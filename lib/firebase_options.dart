// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDhTc5Htc_Lb6UIdiaGARKzX2u-5NVwJOM',
    appId: '1:569282798528:web:526898f5bd4fa646bb5e25',
    messagingSenderId: '569282798528',
    projectId: 'daily-missions-app',
    authDomain: 'daily-missions-app.firebaseapp.com',
    storageBucket: 'daily-missions-app.appspot.com',
    measurementId: 'G-GDKBC4RGZ8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDX1Ce6TQUudeguTGVqpEC7NFOQ86Z-IGE',
    appId: '1:569282798528:android:4af735ffe77a03b3bb5e25',
    messagingSenderId: '569282798528',
    projectId: 'daily-missions-app',
    storageBucket: 'daily-missions-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAjrLa03sxy4J0ielm7tk88pC0Hg0glL2Y',
    appId: '1:569282798528:ios:619b5b6cf2708bb4bb5e25',
    messagingSenderId: '569282798528',
    projectId: 'daily-missions-app',
    storageBucket: 'daily-missions-app.appspot.com',
    iosBundleId: 'com.example.dailyMissionsApp',
  );
}
