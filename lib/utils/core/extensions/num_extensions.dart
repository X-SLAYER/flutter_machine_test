import 'package:flutter/material.dart';

import '../../../data/locale/general_context.dart';

extension ExtensionsOnNum on num {
  static final size = MediaQuery.of($appContext.navigatorContext).size;
  double get w => size.width * (this / 375);
  double get h => size.height * (this / 812);
}
