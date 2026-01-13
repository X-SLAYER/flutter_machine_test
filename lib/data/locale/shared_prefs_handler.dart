import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHandler {
  SharedPrefsHandler._();
  static late final SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static String readValue(String key) {
    return prefs.getString(key) ?? '';
  }

  static bool readBool(String key) {
    return prefs.getBool(key) ?? false;
  }

  static bool isKeyRegistred(String key) {
    return prefs.getBool(key) != null;
  }

  static List<String> readValues(String key) {
    return prefs.getStringList(key) ?? <String>[];
  }

  static void storeBool(String key, bool value) {
    prefs.setBool(key, value);
    log('$value Stored successfully with key: $key', name: 'Shared Prefs');
  }

  static void storeValue(String key, String value) {
    prefs.setString(key, value);
    log('$value Stored successfully with key: $key', name: 'Shared Prefs');
  }

  static void storeValues(List<String> keys, List<String> values) {
    for (int i = 0; i < keys.length; i++) {
      prefs.setString(keys[i], values[i]);
      log(
        '${values[i]} Stored successfully with key: ${keys[i]}',
        name: 'Shared Prefs',
      );
    }
  }

  static void storeJson(String key, Map<String, dynamic> value) {
    prefs.setString(key, jsonEncode(value));
    log('$value Stored successfully with key: $key', name: 'Shared Prefs');
  }

  static Map<String, dynamic> readJson(String key) {
    return prefs.getString(key) != null
        ? jsonDecode(prefs.getString(key)!)
        : <String, dynamic>{};
  }

  static void storeValueList(String key, List<String> value) {
    prefs.setStringList(key, value);
    log('$value Stored successfully with key: $key', name: 'Shared Prefs');
  }

  static void removeKey(String key) {
    prefs.remove(key);
  }

  static void storeJsonList(String key, List<Map<String, dynamic>?> jsonList) {
    prefs.setStringList(key, jsonList.map((e) => jsonEncode(e)).toList());
    log('$jsonList Stored successfully with key: $key', name: 'Shared Prefs');
  }

  static List<Map<String, dynamic>?> readJsonList(String key) {
    return prefs
            .getStringList(key)
            ?.map((e) => jsonDecode(e) as Map<String, dynamic>)
            .toList() ??
        [];
  }
}
