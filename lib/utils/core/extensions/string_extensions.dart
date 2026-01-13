import '../../../data/locale/general_context.dart';
import '../../../stores/language/store.dart';

extension EntendBoolOnNullString on String? {
  bool get isEmptyOrNull => this == null || this!.isEmpty;
  String get translate => i18n($appContext.navigatorContext, this!);
  String translateMap(Map<String, String> map) {
    String input = i18n($appContext.navigatorContext, this!);
    for (final entry in map.entries) {
      input = input.replaceAll(entry.key, entry.value);
    }
    return input;
  }

  String get shortName {
    return this!.split(' ').map((e) => e[0]).join().toUpperCase();
  }
}

extension EntendBoolOnString on String {
  String get toNumFormat {
    return RegExp(r'^[0-9]$').hasMatch(toString()) ? '0$this' : this;
  }

  String get toShortName =>
      split(' ').take(2).map((e) => e[0]).join().toUpperCase();
}
