import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';
import 'utils/core/app_config/app_config.dart';
import 'utils/core/app_config/utils/flavours.dart';
import 'widgets/dev_banner.dart';

void main() {
  BuildEnvironment.init(
    flavor: BuildFlavor.staging,
    baseUrl: 'https://raw.githubusercontent.com',
  );
  runApp(
    ProviderScope(
      child: DevBanner(
        hidden: false,
        message: env.flavor.name,
        color: const Color(0xFFA885D8),
        child: const MyApp(),
      ),
    ),
  );
}
