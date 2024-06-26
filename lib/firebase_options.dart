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
/// 
/// 
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
    apiKey: 'AIzaSyAKXMki_XwCR6JYnzW_Mo0wi_v2mI8OKdo',
    appId: '1:703704100184:web:a9007917f2fd47b57b492d',
    messagingSenderId: '703704100184',
    projectId: 'diploma-auth-af731',
    authDomain: 'diploma-auth-af731.firebaseapp.com',
    databaseURL: 'https://diploma-auth-af731-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'diploma-auth-af731.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAooH27sn2imt-UoT6wMk48TXZF91CyPBQ',
    appId: '1:703704100184:android:57e7077cc234ae8e7b492d',
    messagingSenderId: '703704100184',
    projectId: 'diploma-auth-af731',
    databaseURL: 'https://diploma-auth-af731-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'diploma-auth-af731.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDWs_qq7ta91Mv_4wxRiR8zxATO_nA3uwQ',
    appId: '1:703704100184:ios:b5fbeef71c1ddcf47b492d',
    messagingSenderId: '703704100184',
    projectId: 'diploma-auth-af731',
    databaseURL: 'https://diploma-auth-af731-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'diploma-auth-af731.appspot.com',
    iosBundleId: 'com.example.diploma1610',
  );
}
