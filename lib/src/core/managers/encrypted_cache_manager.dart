import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EncryptedCacheManager {
  final FlutterSecureStorage _storage;

  EncryptedCacheManager({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
            );

  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  Future<String> readOrDefault(String key, String defaultValue) async {
    final val = await read(key);
    return val == null || val.isEmpty ? defaultValue : val;
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }
}
