import 'package:flutter/foundation.dart';

class ApiConfig {
  // ignore: constant_identifier_names
  static String get BASE_URL {
    if (kIsWeb) {
      return 'http://localhost:3000/';
    }
    
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'http://10.0.2.2:3000/';
      case TargetPlatform.iOS:
        return 'http://localhost:3000/';
      default:
        return 'http://localhost:3000/';
    }
  }
}