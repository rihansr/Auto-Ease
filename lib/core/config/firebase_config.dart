import 'package:firebase_core/firebase_core.dart'
    show Firebase, FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import '../service/analytics_service.dart';

final firebaseConfig = FirebaseConfig.value;

class FirebaseConfig {
  static FirebaseConfig get value => FirebaseConfig._();
  FirebaseConfig._();

  Future<void> init() async {
    Firebase.apps.isEmpty
        ? await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          )
        : Firebase.app();

    await Future.wait([
      analyticsService.init(),
    ]);
  }
}

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDGBXqGE32h7Q3n9NXMEOyIMqBMGWixeag',
    appId: '1:863257218129:android:697c0dd425aad1f8cebc70',
    messagingSenderId: '493565510971',
    projectId: 'auto-ease-439108',
    storageBucket: 'auto-ease-439108.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD8-2usaYnG08g1etI9AhMS4DGg9Ppmw_0',
    appId: '1:493565510971:ios:5626362bf742b2fe45631e',
    messagingSenderId: '493565510971',
    projectId: 'auto-ease-439108',
    storageBucket: 'auto-ease-439108.appspot.com',
    iosBundleId: 'com.example.autoease',
  );
}
