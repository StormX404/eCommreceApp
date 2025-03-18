import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AStorage {
  static FirebaseApp? _secondaryApp;

  // Initialize Firebase secondary app based on platform (Android/iOS)
  static Future<FirebaseApp> fireBaseInit() async {
    if (_secondaryApp == null) {
      if (Platform.isAndroid) {
        // Android FirebaseOptions
        _secondaryApp = await Firebase.initializeApp(
          name: 'SecondaryApp',
          options: const FirebaseOptions(
            apiKey: 'AlzaSyCEFTpXAAPo_ZTxQ3ggwl0WzAHFjz0Iss',
            appId: '1:849512846547:android:c0bc545306b03a41a8f026',
            projectId: 'chat-app-a37e7',
            storageBucket: 'chat-app-a37e7.appspot.com',
            messagingSenderId: '849512846547',
          ),
        );
      } else if (Platform.isIOS) {
        // iOS FirebaseOptions
        _secondaryApp = await Firebase.initializeApp(
          name: 'SecondaryApp',
          options: const FirebaseOptions(
            apiKey: 'AlzaSyCEFTpXAAPo_ZTxQ3ggwl0WzAHFjz0Iss',
            appId: '1:849512846547:ios:9225289c174e109ae8f026',
            projectId: 'chat-app-a37e7',
            storageBucket: 'chat-app-a37e7.appspot.com',
            messagingSenderId: '849512846547',
          ),
        );
      } else {
        throw UnsupportedError("Unsupported platform");
      }
    }
    return _secondaryApp!;
  }

  // Initialize Firebase Storage for the secondary app
  static Future<FirebaseStorage> getStorageInstance() async {
    final app = await fireBaseInit();
    return FirebaseStorage.instanceFor(
      app: app,
      bucket: 'gs://chat-app-a37e7.appspot.com',
    );
  }
}