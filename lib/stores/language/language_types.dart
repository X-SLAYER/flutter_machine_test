import 'package:ez_validator/ez_validator.dart';
import 'package:flutter/material.dart';

import '../../constant/assets.dart';
import '../../data/locale/validator_locals/ar_locale.dart';
import '../../data/locale/validator_locals/en_locale.dart';

enum LanguageTypes {
  arabic,
  english;

  Locale get locale => switch (this) {
    LanguageTypes.arabic => const Locale('ar', 'TN'),
    LanguageTypes.english => const Locale('en', 'US'),
  };

  String get localeName => switch (this) {
    LanguageTypes.arabic => 'ar',
    LanguageTypes.english => 'en',
  };

  EzLocale get validatorLocale => switch (this) {
    LanguageTypes.arabic => const ArLocale(),
    LanguageTypes.english => const EnLocale(),
  };

  String get icon => switch (this) {
    LanguageTypes.arabic => Assets.qatar,
    LanguageTypes.english => Assets.usa,
  };
}
