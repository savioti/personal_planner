class MapUtils {
  static String? getNestedValue(Map<String, dynamic> map, String key) {
    final keys = key.split('.');
    dynamic value = map;

    for (final k in keys) {
      if (value is Map<String, dynamic> && value.containsKey(k)) {
        value = value[k];
      } else {
        return null;
      }
    }

    return value is String ? value : null;
  }
}
