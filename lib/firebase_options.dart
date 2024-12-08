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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCkgR7QNH32n1hTfd_jYk7y69c-kUW49ws',
    appId: '1:814032161170:web:b4257427bc78568bfd994b',
    messagingSenderId: '814032161170',
    projectId: 'kanban-innoscripta',
    authDomain: 'kanban-innoscripta.firebaseapp.com',
    storageBucket: 'kanban-innoscripta.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXbOQOt7Pr-bXndshPuFdjyIk_XZFaETI',
    appId: '1:814032161170:android:b37eb51f09059712fd994b',
    messagingSenderId: '814032161170',
    projectId: 'kanban-innoscripta',
    storageBucket: 'kanban-innoscripta.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBEbkf-7EtSKiKhn-zX-tVkMXXV2rU5Z4g',
    appId: '1:814032161170:ios:c58212178b8b4714fd994b',
    messagingSenderId: '814032161170',
    projectId: 'kanban-innoscripta',
    storageBucket: 'kanban-innoscripta.firebasestorage.app',
    iosBundleId: 'com.example.kanban',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBEbkf-7EtSKiKhn-zX-tVkMXXV2rU5Z4g',
    appId: '1:814032161170:ios:c58212178b8b4714fd994b',
    messagingSenderId: '814032161170',
    projectId: 'kanban-innoscripta',
    storageBucket: 'kanban-innoscripta.firebasestorage.app',
    iosBundleId: 'com.example.kanban',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCkgR7QNH32n1hTfd_jYk7y69c-kUW49ws',
    appId: '1:814032161170:web:9c380c2c9e1b13f2fd994b',
    messagingSenderId: '814032161170',
    projectId: 'kanban-innoscripta',
    authDomain: 'kanban-innoscripta.firebaseapp.com',
    storageBucket: 'kanban-innoscripta.firebasestorage.app',
  );
}
