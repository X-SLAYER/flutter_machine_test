import 'package:flutter/widgets.dart';

final $appContext = CurrentApp();

class CurrentApp {
  final GlobalKey appKey = GlobalKey();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext get context => appKey.currentContext!;
  BuildContext get navigatorContext => navigatorKey.currentContext!;
}
