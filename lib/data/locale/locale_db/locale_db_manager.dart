import '../../network/dio/common/xnetwork_model.dart';
import '../shared_prefs_handler.dart';

typedef FromJson<T> = T Function(Map<String, dynamic> json);

class XLocalStorage {
  const XLocalStorage._();

  static void save<T extends XNetworkModel>(
    String key,
    T value,
  ) {
    SharedPrefsHandler.storeJson(key, value.toJson() ?? {});
  }

  static T? read<T extends XNetworkModel>(
    String key,
    FromJson<T> fromJson,
  ) {
    final json = SharedPrefsHandler.readJson(key);
    return json.isNotEmpty ? fromJson(json) : null;
  }

  static void saveList<T extends XNetworkModel>(
    String key,
    List<T> list,
  ) {
    final jsonList = list.map((e) => e.toJson()).toList();
    SharedPrefsHandler.storeJsonList(key, jsonList);
  }

  static void storeJsonToList(String key, Map<String, dynamic> object) {
    final jsonList = SharedPrefsHandler.readJsonList(key);
    jsonList.add(object);
    SharedPrefsHandler.storeJsonList(key, jsonList);
  }

  static void storeJsonList(String key, List<Map<String, dynamic>> list) {
    SharedPrefsHandler.storeJsonList(key, list);
  }

  static List<T> readList<T>(
    String key,
    FromJson<T> fromJson,
  ) {
    final jsonList = SharedPrefsHandler.readJsonList(key);
    return jsonList.map((e) => fromJson(e ?? {})).toList();
  }

  static void delete(String key) {
    SharedPrefsHandler.removeKey(key);
  }
}
