import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class EnvManager {
  static Future<void> init({String fileName = '.env'}) async {
    await dotenv.load(fileName: fileName);
  }

  static String get baseUrl =>
      dotenv.get('BASE_URL', fallback: 'https://node-js-clean-arc-template.onrender.com');
}
