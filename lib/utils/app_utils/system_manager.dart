import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/locale/general_context.dart';
import '../../features/view_models/base_main.dart';
import '../animations/push_circular_screen.dart';
import '../animations/route_transation.dart';

void hideStatusBar() {
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: <SystemUiOverlay>[],
  );
}

void revertStatusBar() {
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: <SystemUiOverlay>[SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
}

void changeStatusBarColor() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFE2EDF8),
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}

Future<dynamic> pushScreen<T>(Widget page, {T? viewModel}) async {
  return Navigator.push(
    $appContext.navigatorContext,
    MaterialPageRoute(
      builder: (ctx) => viewModel == null
          ? page
          : ViewModel(
              builder: (_) => page,
              model: T as ChangeNotifier,
            ),
    ),
  );
}

Future<dynamic> pushScreenWithTransitions<T>(
  Widget page,
  AnimationType animation, {
  T? viewModel,
}) async {
  return Navigator.of($appContext.navigatorContext).push(
    PageRouteTransition(
      animationType: animation,
      builder: (ctx) => viewModel == null
          ? page
          : ViewModel(
              builder: (_) => page,
              model: T as ChangeNotifier,
            ),
    ),
  );
}

Future<dynamic> pushReplaceScreenWithTransitions<T>(
  Widget page,
  AnimationType animation, {
  T? viewModel,
}) async {
  return Navigator.of($appContext.navigatorContext).pushReplacement(
    PageRouteTransition(
      animationType: animation,
      builder: (ctx) => viewModel == null
          ? page
          : ViewModel(
              builder: (_) => page,
              model: T as ChangeNotifier,
            ),
    ),
  );
}

Future<dynamic> pushNamed(String routeName, {Object? arguments}) async {
  return Navigator.of($appContext.navigatorContext).pushNamed(
    routeName,
    arguments: arguments,
  );
}

Future<dynamic> pushReplaceScreen<T>(Widget page, {T? viewModel}) async {
  return Navigator.pushReplacement(
    $appContext.navigatorContext,
    MaterialPageRoute(
      builder: (ctx) => viewModel == null
          ? page
          : ViewModel(
              builder: (_) => page,
              model: T as ChangeNotifier,
            ),
    ),
  );
}

Future<dynamic> pushRemoveUntil(String route) async {
  return Navigator.of($appContext.navigatorContext).pushNamedAndRemoveUntil(
    route,
    (Route<dynamic> route) => false,
  );
}

Future<dynamic> pushRevealScreen<T>(
  Widget page, {
  Alignment? alignment,
  T? viewModel,
}) async {
  return Navigator.of($appContext.navigatorContext).push(
    RevealRoute(
      page: viewModel == null
          ? page
          : ViewModel(
              builder: (_) => page,
              model: T as ChangeNotifier,
            ),
      centerAlignment: alignment,
    ),
  );
}

Future<dynamic> pushReplaceRevealScreen<T>(
  Widget page, {
  Alignment? alignment,
  T? viewModel,
}) async {
  return Navigator.of($appContext.navigatorContext).pushReplacement(
    RevealRoute(
      page: viewModel == null
          ? page
          : ViewModel(
              builder: (_) => page,
              model: T as ChangeNotifier,
            ),
      centerAlignment: alignment,
    ),
  );
}
