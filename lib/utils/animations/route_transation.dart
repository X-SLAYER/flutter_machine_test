import 'package:flutter/material.dart';

enum AnimationType {
  slideRight,
  slideLeft,
  slideUp,
  slideDown,
  fade,
  scale,
}

class PageRouteTransition extends MaterialPageRoute {
  AnimationType animationType;
  Cubic curves;

  PageRouteTransition({
    @required WidgetBuilder? builder,
    super.settings,
    this.animationType = AnimationType.slideRight,
    this.curves = Curves.easeInOut,
    super.maintainState,
    super.fullscreenDialog,
  }) : super(builder: builder!);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    Animation customAnimation;
    if (animationType == AnimationType.slideRight) {
      customAnimation =
          Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).animate(
        CurvedAnimation(
          parent: animation,
          curve: curves,
        ),
      );
      return SlideTransition(
        position: customAnimation as Animation<Offset>,
        child: child,
      );
    } else if (animationType == AnimationType.slideLeft) {
      customAnimation = Tween(begin: const Offset(-1.0, 0.0), end: Offset.zero)
          .animate(CurvedAnimation(
        parent: animation,
        curve: curves,
      ));
      return SlideTransition(
        position: customAnimation as Animation<Offset>,
        child: child,
      );
    } else if (animationType == AnimationType.slideUp) {
      customAnimation = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)
          .animate(CurvedAnimation(
        parent: animation,
        curve: curves,
      ));
      return SlideTransition(
        position: customAnimation as Animation<Offset>,
        child: child,
      );
    } else if (animationType == AnimationType.slideDown) {
      customAnimation = Tween(begin: const Offset(0.0, -1.0), end: Offset.zero)
          .animate(CurvedAnimation(
        parent: animation,
        curve: curves,
      ));
      return SlideTransition(
        position: customAnimation as Animation<Offset>,
        child: child,
      );
    } else if (animationType == AnimationType.fade) {
      customAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animation,
        curve: curves,
      ));
      return FadeTransition(
        opacity: customAnimation as Animation<double>,
        child: child,
      );
    } else if (animationType == AnimationType.scale) {
      customAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animation,
        curve: curves,
      ));
      return ScaleTransition(
        scale: customAnimation as Animation<double>,
        child: child,
      );
    } else {
      throw Exception('Animation type is invalid or null');
    }
  }
}
