import 'package:ez_validator/ez_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'language_types.dart';

class AppLocalization extends ChangeNotifier {
  AppLocalization();

  Locale _locale = const Locale('en');
  String selectedLanguageCode = 'en';
  LanguageTypes get languageType => LanguageTypes.values.firstWhere(
    (element) => element.locale.languageCode == selectedLanguageCode,
    orElse: () => LanguageTypes.english,
  );
  String get dateTimeFormat => '$dateFormat $timeFormat aa';

  String get dateFormat => isAr ? 'yyyy/MM/dd' : 'dd/MM/yyyy';
  String get timeFormat => isAr ? 'mm:hh' : 'hh:mm';
  Locale get getLocale => _locale;
  bool get isAr => _locale.languageCode == 'ar';

  Alignment get centerAlignment =>
      isAr ? Alignment.centerLeft : Alignment.centerRight;
  Alignment get topAlignment => isAr ? Alignment.topRight : Alignment.topLeft;
  Alignment get bottomAlignment =>
      isAr ? Alignment.bottomRight : Alignment.bottomLeft;

  void toggleLocal(LanguageTypes languageType) {
    _locale = languageType.locale;
    selectedLanguageCode = languageType.locale.languageCode;
    Intl.systemLocale = languageType.locale.languageCode;
    Intl.defaultLocale = languageType.locale.languageCode;
    EzValidator.setLocale(languageType.validatorLocale);
    notifyListeners();
  }

  void autoToggleLocal() {
    if (languageType == LanguageTypes.arabic) {
      toggleLocal(LanguageTypes.english);
    } else {
      toggleLocal(LanguageTypes.arabic);
    }
  }
}
