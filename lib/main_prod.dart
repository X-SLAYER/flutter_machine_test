import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';
import 'utils/core/app_config/app_config.dart';
import 'utils/core/app_config/env_variables.dart';
import 'utils/core/app_config/utils/flavours.dart';
import 'widgets/dev_banner.dart';

void main() {
  BuildEnvironment.init(
    flavor: BuildFlavor.development,
    baseUrl: 'https://raw.githubusercontent.com',
    variables: const EnvVariables(
      oneSignalID: '3944f9f5-d259-4f62-8017-6802ad404a22',
    ),
  );
  runApp(
    ProviderScope(
      child: DevBanner(
        message: env.flavor.name,
        color: const Color(0xFF02BB83),
        child: const MyApp(),
      ),
    ),
  );
}
