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
    apiKey: 'AIzaSyBN1-wW2vOefafZzcJjZJHgHq9i_2dw71s',
    appId: '1:482040415104:web:d5b6acb8d935187a4f3765',
    messagingSenderId: '482040415104',
    projectId: 'bgitestapp',
    authDomain: 'bgitestapp.firebaseapp.com',
    storageBucket: 'bgitestapp.appspot.com',
    measurementId: 'G-0NVGVHM5R1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAkou7sl60DdEHkTDQ0JFxG-Ms7Pzl9CKk',
    appId: '1:482040415104:android:6704000a50fb18984f3765',
    messagingSenderId: '482040415104',
    projectId: 'bgitestapp',
    storageBucket: 'bgitestapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA4dh1RgZjTIWGkm--RqcjEmqonKfhjtC8',
    appId: '1:482040415104:ios:c4475b41096724bc4f3765',
    messagingSenderId: '482040415104',
    projectId: 'bgitestapp',
    storageBucket: 'bgitestapp.appspot.com',
    iosClientId: '482040415104-m15hdtb5d2m0g27ak6g2fioc0vmk4j2j.apps.googleusercontent.com',
    iosBundleId: 'com.example.bgiTestApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA4dh1RgZjTIWGkm--RqcjEmqonKfhjtC8',
    appId: '1:482040415104:ios:c4475b41096724bc4f3765',
    messagingSenderId: '482040415104',
    projectId: 'bgitestapp',
    storageBucket: 'bgitestapp.appspot.com',
    iosClientId: '482040415104-m15hdtb5d2m0g27ak6g2fioc0vmk4j2j.apps.googleusercontent.com',
    iosBundleId: 'com.example.bgiTestApp',
  );
}
