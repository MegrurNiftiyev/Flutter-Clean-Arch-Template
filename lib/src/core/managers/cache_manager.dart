import 'package:hive_flutter/hive_flutter.dart';

class CacheManager {
  static Future<void> init() async {
    await Hive.initFlutter();
  }

  Future<Box<dynamic>> openBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<dynamic>(boxName);
    }
    return await Hive.openBox<dynamic>(boxName);
  }

  Future<void> put<T>(String boxName, String key, T value) async {
    final box = await openBox(boxName);
    await box.put(key, value);
  }

  Future<T?> get<T>(String boxName, String key, {T? defaultValue}) async {
    final box = await openBox(boxName);
    final value = box.get(key, defaultValue: defaultValue);
    if (value is T) return value;
    return defaultValue;
  }

  Future<T> getOrDefault<T>(
    String boxName,
    String key,
    T defaultValue,
  ) async {
    final val = await get<T>(boxName, key, defaultValue: defaultValue);
    return val ?? defaultValue;
  }

  Future<void> delete<T>(String boxName, String key) async {
    final box = await openBox(boxName);
    await box.delete(key);
  }

  Future<void> clear<T>(String boxName) async {
    final box = await openBox(boxName);
    await box.clear();
  }
}
