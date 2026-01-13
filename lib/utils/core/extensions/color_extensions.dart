import 'dart:ui';

extension ExtendColors on Color {
  bool isDarkColor() {
    final double darkness = 1 - (0.299 * r + 0.587 * g + 0.114 * b) / 255;
    if (darkness < 0.5) {
      return false;
    } else {
      return true;
    }
  }
}
