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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9NXmMYVYo_Gd585aFmqtKp2VshjpQ_Bg',
    appId: '1:255263651156:android:0711e80085b906e064c4c1',
    messagingSenderId: '255263651156',
    projectId: 'bwi-pradhan-group',
    storageBucket: 'bwi-pradhan-group.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCvtwK_5ufsGYSEIY8ee3XW83L1dYSZR48',
    appId: '1:255263651156:ios:791f35198bcfa89d64c4c1',
    messagingSenderId: '255263651156',
    projectId: 'bwi-pradhan-group',
    storageBucket: 'bwi-pradhan-group.appspot.com',
    iosBundleId: 'com.example.pradhangroup',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCvtwK_5ufsGYSEIY8ee3XW83L1dYSZR48',
    appId: '1:255263651156:ios:791f35198bcfa89d64c4c1',
    messagingSenderId: '255263651156',
    projectId: 'bwi-pradhan-group',
    storageBucket: 'bwi-pradhan-group.appspot.com',
    iosBundleId: 'com.example.pradhangroup',
  );
}
