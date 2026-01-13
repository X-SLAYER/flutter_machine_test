// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

final $styles = AppStyle();

@immutable
class AppStyle {
  late final _Corners corners = _Corners();

  late final _Shadows shadows = _Shadows();

  late final _Insets insets = _Insets();

  final _Times times = _Times();

  late final _Colors colors = _Colors();
}

@immutable
class _Times {
  final Duration superFast = const Duration(milliseconds: 100);
  final Duration fast = const Duration(milliseconds: 300);
  final Duration med = const Duration(milliseconds: 600);
  final Duration slow = const Duration(milliseconds: 900);
  final Duration pageTransition = const Duration(milliseconds: 200);
}

@immutable
class _Corners {
  late final double sm = 4;
  late final double md = 8;
  late final double nm = 10;
  late final double lg = 12;
  late final double xl1 = 20;
  late final double xl = 32;
  late final double xxl = 44.0;
}

@immutable
class _Insets {
  late final double xxs = 4;
  late final double xs = 8;
  late final double min = 10;
  late final double sm = 16;
  late final double md = 24;
  late final double lg = 32;
  late final double xl = 48;
  late final double xxl = 56;
  late final double offset = 80;
}

@immutable
class _Shadows {
  final textSoft = [
    Shadow(
      color: Colors.black.withValues(alpha: .25),
      offset: const Offset(0, 2),
      blurRadius: 4,
    ),
  ];
  final text = [
    Shadow(
      color: Colors.black.withValues(alpha: .6),
      offset: const Offset(0, 2),
      blurRadius: 2,
    ),
  ];
  final textStrong = [
    Shadow(
      color: Colors.black.withValues(alpha: .6),
      offset: const Offset(0, 4),
      blurRadius: 6,
    ),
  ];

  final boxShadowSoft = BoxShadow(
    color: Colors.black.withValues(alpha: .2),
    blurRadius: 4,
    offset: const Offset(0, 4),
  );

  final cardShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: .16),
      blurRadius: 3,
      offset: const Offset(0, 3),
    ),
  ];

  final softShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: .05),
      blurRadius: 3,
      offset: const Offset(0, 3),
    ),
  ];
}

@immutable
class _Colors {
  final Color accent1 = const Color(0xFFD73556);
  final Color accent2 = const Color(0xFFC0269E);
  final Color softPink = const Color(0xFFFFF5F7);
  final Color softGrey = const Color(0xFFF2F2F2);
  final Color offWhite = const Color(0xFFF8ECE5);
  final Color caption = const Color(0xFF7D7873);
  final Color body = const Color(0xFF514F4D);
  final Color greyLight = const Color(0xFFE5E5E5);
  final Color greyStrong = const Color(0xFF272625);
  final Color greyMedium = const Color(0xFF9D9995);
  final Color white = Colors.white;
  final Color secondTone = const Color(0xFFF5F5F8);
  final Color black = const Color(0xFF1E1B18);
  final Color textColor = const Color(0xFF1E1B18);
  final Color statusBarColor = const Color(0xFF333132);
  final Color breezyViolet = const Color(0xFFCECFDF);
  final Color placeBo = const Color(0xFFE7E7E7);
  final Color red = const Color(0xFFBF2645);
  final Color surface = const Color(0xFFFBF4F5);
  final Color green = const Color(0xFF35d7b6);
  final Color blueLink = const Color(0xFF007AFF);
  final Color gold = const Color(0xFFD4AF37);
  final Color primaryContainer = const Color(0xFFE5E5E5);
  final Color silver = const Color(0xFFC0C0C0);
  final Color borderColor = const Color(0xFFE0E0E0);
  final Color warning = const Color(0xFFFFF3CD);
}
