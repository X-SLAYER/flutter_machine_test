import 'package:flutter/material.dart';

class ColorBrightness {
  late Color _color;

  ColorBrightness(Color color) {
    _color = Color.fromARGB(
      color.a.toInt(),
      color.r.toInt(),
      color.g.toInt(),
      color.b.toInt(),
    );
  }

  bool get isDark => getBrightness() < 128.0;

  bool get isLight => !isDark;

  Brightness get matchedBrightness =>
      isLight ? Brightness.dark : Brightness.light;

  double getBrightness() {
    return (_color.r.toInt() * 299 +
            _color.g.toInt() * 587 +
            _color.b.toInt() * 114) /
        1000;
  }
}
