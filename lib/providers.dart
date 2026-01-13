import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'stores/language/app_localization.dart';
import 'stores/providers/app_theme.dart';
import 'stores/providers/main_provider.dart';

final appThemeProvider = ChangeNotifierProvider<AppTheme>((ref) {
  return AppTheme();
});

final appLocalizationProvider = ChangeNotifierProvider<AppLocalization>((ref) {
  return AppLocalization();
});

final mainProvider = ChangeNotifierProvider<MainProvider>((ref) {
  return MainProvider();
});
