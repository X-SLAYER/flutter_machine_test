import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class RouteObservor extends NavigatorObserver {
  static final navigationStack = <RouteStackItem>[];

  static String? get currentRouteName =>
      navigationStack.isEmpty ? null : navigationStack.last.name;

  @override
  void didPop(Route route, Route? previousRoute) {
    if (previousRoute != null) {
      final route = navigationStack.removeLast();
      $logger.t('🍉 Popped route: ${route.name}');
    }
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    navigationStack.add(RouteStackItem.fromRoute(route));
    $logger.f('🍉 Pushed route: ${route.settings.name}');
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    if (previousRoute != null) {
      final navigation = navigationStack.removeLast();
      $logger.t('🍉 Removed route: ${navigation.name}');
    }
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (oldRoute != null) {
      final old = navigationStack.removeLast();
      $logger.t('🍉 Replaced route: ${old.name}');
    }
    if (newRoute != null) {
      navigationStack.add(RouteStackItem.fromRoute(newRoute));
    }
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}

class RouteStackItem extends Equatable {
  final String? name;
  final Object? args;

  const RouteStackItem({
    required this.name,
    required this.args,
  });

  factory RouteStackItem.fromRoute(Route route) => RouteStackItem(
        name: route.settings.name,
        args: route.settings.arguments,
      );

  @override
  List<Object?> get props => [name, args];
}
