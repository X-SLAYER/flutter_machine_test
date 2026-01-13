import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    if (_current == null) {
      throw StateError('AppLocalizations has not been initialized');
    }
    return _current!;
  }

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  late Map<String, dynamic> _localizedStrings;

  Future<bool> load() async {
    final String jsonString = await rootBundle.loadString(
      'languages/${locale.languageCode}.json',
    );
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value);
    });
    _current = this;
    return true;
  }

  String? translate(String key) {
    return _localizedStrings[key];
  }

  dynamic translateNested(String key) {
    final keys = key.split('.');
    dynamic currentValue = _localizedStrings;

    for (final String k in keys) {
      if (currentValue != null && currentValue is Map) {
        currentValue = currentValue[k];
      } else {
        return null;
      }
    }
    return currentValue;
  }

  String translatePlural(String key, int count) {
    final Map<String, dynamic>? pluralMap = translateNested(key);
    if (pluralMap == null) {
      return key;
    }
    String pluralKey;
    if (count <= 0) {
      pluralKey = 'zero';
    } else if (count == 1) {
      pluralKey = 'one';
    } else if (count == 2) {
      pluralKey = 'two';
    } else if (count >= 3 && count <= 4) {
      pluralKey = 'few';
    } else if (count >= 5) {
      pluralKey = 'many';
    } else {
      pluralKey = 'other';
    }
    final String template = pluralMap[pluralKey] ?? pluralMap['other'] ?? key;
    return template.replaceAll('{}', count.toString());
  }

  static String tr(
    Object key, {
    int? count,
    Map<String, dynamic> args = const {},
  }) {
    final xKey = key.toString();
    late String output;
    if (count != null) {
      output = current.translatePlural(xKey, count);
    } else if (xKey.contains('.')) {
      output = current.translateNested(xKey) ?? '{{$xKey}}';
    } else {
      output = current.translate(xKey) ?? '{{$xKey}}';
    }

    if (args.isNotEmpty) {
      for (final entry in args.entries) {
        output = output.replaceAll('{{${entry.key}}}', entry.value.toString());
      }
    }
    return output;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return [
      'en',
      'fr',
      'af',
      'de',
      'es',
      'id',
      'pt',
      'tr',
      'hi',
      'ar',
    ].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => true;
}

String i18n(BuildContext context, Object key, [int? count]) {
  final xKey = key.toString();
  final AppLocalizations localizations = AppLocalizations.of(context);
  if (count != null) {
    return i18nPlural(context, xKey, count);
  } else if (xKey.contains('.')) {
    return localizations.translateNested(xKey) ?? '{{$xKey}}';
  } else {
    return localizations.translate(xKey) ??
        localizations.translate(xKey.toLowerCase()) ??
        '{{$xKey}}';
  }
}

String i18nPlural(BuildContext context, String key, int count) {
  final AppLocalizations localizations = AppLocalizations.of(context);
  return localizations.translatePlural(key, count);
}
