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
    apiKey: 'AIzaSyA4PHL5Tj6boqz6PymGqoC1im_DoQHDIF0',
    appId: '1:482808293457:web:516490b32f754e6f73b070',
    messagingSenderId: '482808293457',
    projectId: 'instaudemy-bada7',
    authDomain: 'instaudemy-bada7.firebaseapp.com',
    storageBucket: 'instaudemy-bada7.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBuf7UaA1wdpt1y49uwBhl8-ebzhc3vl0s',
    appId: '1:482808293457:android:ebd4d636f8413c8673b070',
    messagingSenderId: '482808293457',
    projectId: 'instaudemy-bada7',
    storageBucket: 'instaudemy-bada7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDqlFkTYp_g9fUPQgs7bIN8cJwBMWwZEm8',
    appId: '1:482808293457:ios:b66d44fd8f9d7b7073b070',
    messagingSenderId: '482808293457',
    projectId: 'instaudemy-bada7',
    storageBucket: 'instaudemy-bada7.appspot.com',
    iosBundleId: 'com.example.instaudemy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDqlFkTYp_g9fUPQgs7bIN8cJwBMWwZEm8',
    appId: '1:482808293457:ios:8da4dbe01778e74d73b070',
    messagingSenderId: '482808293457',
    projectId: 'instaudemy-bada7',
    storageBucket: 'instaudemy-bada7.appspot.com',
    iosBundleId: 'com.example.instaudemy.RunnerTests',
  );
}
