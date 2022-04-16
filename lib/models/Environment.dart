import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (kReleaseMode) return 'prd.env';

    return 'dev.env';
  }

  static String get apiKey {
    return dotenv.env['API_KEY'] ?? 'noApiKey';
  }
}
