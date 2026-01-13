extension MapExtensions on Map<dynamic, dynamic> {
  Map<dynamic, dynamic> get nestMap {
    final Map<dynamic, dynamic> nestedMap = {};
    forEach((key, value) {
      final List<String> keys = key.toString().split('.');
      Map currentLevel = nestedMap;
      for (int i = 0; i < keys.length - 1; i++) {
        if (!currentLevel.containsKey(keys[i])) {
          currentLevel[keys[i]] = {};
        }
        currentLevel = currentLevel[keys[i]];
      }
      currentLevel[keys.last] = value;
    });
    return nestedMap;
  }
}

extension MapX<K, V> on Map<K, V> {
  Map<K, V> get withoutNullValues =>
      {...this}..removeWhere((key, value) => value == null);
}
