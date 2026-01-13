import 'dart:developer';
import 'dart:io';

import 'package:ez_validator/ez_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:intl/intl.dart';

import '../../../constant/shared_prefences.dart';
import '../../../data/locale/shared_prefs_handler.dart';
import '../../../data/locale/validator_locals/common.dart';
import '../../../stores/language/language_types.dart';
import 'env_variables.dart';
import 'utils/env_schema.dart';
import 'utils/flavours.dart';

BuildEnvironment get env => _env!;
BuildEnvironment? _env;

class BuildEnvironment {
  final String baseUrl;
  final BuildFlavor flavor;
  final EnvVariables variables;

  BuildEnvironment._init({
    required this.flavor,
    required this.baseUrl,
    this.variables = const EnvVariables.empty(),
  });

  static Future<void> runInStart() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SharedPrefsHandler.init();
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    if (Platform.isAndroid) {
      await FlutterDisplayMode.setHighRefreshRate();
    }
    if (SharedPrefsHandler.readValue(SharedPrefsKeys.language).isEmpty) {
      final String languageCode = Platform.localeName.split('_')[0];
      final currentCode =
          LanguageTypes.values.map((e) => e.localeName).contains(languageCode)
          ? languageCode
          : 'en';
      SharedPrefsHandler.storeValue(
        SharedPrefsKeys.language,
        currentCode,
      );
      Intl.defaultLocale = currentCode;
      Intl.systemLocale = currentCode;
      EzValidator.setLocale(validatorLocals[currentCode]!);
    } else {
      final currentCode = SharedPrefsHandler.readValue(
        SharedPrefsKeys.language,
      );
      SharedPrefsHandler.storeValue(
        SharedPrefsKeys.language,
        currentCode,
      );
      Intl.defaultLocale = currentCode;
      Intl.systemLocale = currentCode;
      EzValidator.setLocale(validatorLocals[currentCode]!);
    }
    // await initOneSingalPlatformState();
  }

  static Future<void> init({
    required BuildFlavor flavor,
    required String baseUrl,
    EnvVariables variables = const EnvVariables.empty(),
  }) async {
    final (data, errors) = envSchema.validateSync(variables.toJson());
    if (errors.isNotEmpty) {
      throw Exception('Invalid environment variables: $errors');
    }
    _env ??= BuildEnvironment._init(
      flavor: flavor,
      baseUrl: baseUrl,
      variables: EnvVariables.fromJson(data),
    );
    log('Env Variables: $data');
    await runInStart();
  }
}
