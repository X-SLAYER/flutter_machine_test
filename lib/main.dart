import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'data/locale/general_context.dart';
import 'features/presentations/splash/splash_screeen.dart';
import 'providers.dart';
import 'routers.dart';
import 'stores/language/store.dart';
import 'utils/app_utils/route_observor.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = ref.watch(appLocalizationProvider);
    final themeProvider = ref.watch(appThemeProvider);

    return MaterialApp(
      locale: localization.getLocale,
      key: $appContext.appKey,
      navigatorKey: $appContext.navigatorKey,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr', 'FR'),
        Locale('en', 'US'),
        Locale('ar', 'TN'),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        return Locale(localization.selectedLanguageCode);
      },
      debugShowCheckedModeBanner: false,
      title: 'Leave Request System',
      theme: themeProvider.getThemeData,
      home: const SplashScreen(),
      routes: Routes.routes,
      navigatorObservers: [RouteObservor()],
    );
  }
}

final $logger = Logger(
  printer: PrettyPrinter(dateTimeFormat: DateTimeFormat.onlyTime),
);
