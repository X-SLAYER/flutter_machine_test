import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/styles.dart';
import '../../../stores/language/store.dart';

extension ContextProvider on BuildContext {
  String translate(
    Object key, {
    Map<String, dynamic> args = const {},
    int? count,
  }) {
    if (args.isNotEmpty) {
      String input = i18n(this, key, count);
      for (final entry in args.entries) {
        input = input.replaceAll('{{${entry.key}}}', entry.value.toString());
      }
      return input;
    } else {
      return i18n(this, key, count);
    }
  }
}

extension ContextExtensions on BuildContext {
  /// To get a [MediaQuery] directly.
  MediaQueryData get mq => MediaQuery.of(this);

  /// Get MediaQuery Screen Size
  Size get screenSize => mq.size;

  /// Get MediaQuery devicePixelRatio
  double get devicePixelRatio => mq.devicePixelRatio;

  /// Get MediaQuery Screen Padding
  EdgeInsets get screenPadding => mq.padding;

  /// Get MediaQuery Screen Width
  double get screenWidth => mq.size.width;

  /// Get MediaQuery Screen Height
  double get screenHeight => mq.size.height;

  /// Get MediaQuery Screen Width in percentage
  double get widthInPercent => screenWidth / 100;

  /// Get MediaQuery Screen height in percentage
  double get heightInPercent => screenHeight / 100;

  /// Get MediaQuery safearea padding horizontally
  double get safeAreaHorizontal => mq.padding.left + mq.padding.right;

  /// Get MediaQuery safearea padding vertically
  double get safeAreaVertical => mq.padding.top + mq.padding.bottom;

  /// Get MediaQuery Screen Width in percentage including safe area calculation.
  double get safeAreaWidthInPercent => (screenWidth - safeAreaHorizontal) / 100;

  /// Get MediaQuery Screen Height in percentage including safe area calculation.
  double get safeAreaHeightInPercent => (screenHeight - safeAreaVertical) / 100;

  /// Gives you the power to get a portion of the height.
  /// Useful for responsive applications.
  ///
  /// [dividedBy] is for when you want to have a portion of the value you
  /// would get like for example: if you want a value that represents a third
  /// of the screen you can set it to 3, and you will get a third of the height
  ///
  /// [reducedBy] is a percentage value of how much of the height you want
  /// if you for example want 46% of the height, then you reduce it by 54%.
  double heightTransformer({double dividedBy = 1, double reducedBy = 0.0}) =>
      (screenSize.height - ((screenSize.height / 100) * reducedBy)) / dividedBy;

  /// Gives you the power to get a portion of the width.
  /// Useful for responsive applications.
  ///
  /// [dividedBy] is for when you want to have a portion of the value you
  /// would get like for example: if you want a value that represents a third
  /// of the screen you can set it to 3, and you will get a third of the width
  ///
  /// [reducedBy] is a percentage value of how much of the width you want
  /// if you for example want 46% of the width, then you reduce it by 54%.
  double widthTransformer({double dividedBy = 1, double reducedBy = 0.0}) =>
      (screenSize.width - ((screenSize.width / 100) * reducedBy)) / dividedBy;

  /// Divide the height proportionally by the given value
  double ratio({
    double dividedBy = 1,
    double reducedByW = 0.0,
    double reducedByH = 0.0,
  }) =>
      heightTransformer(dividedBy: dividedBy, reducedBy: reducedByH) /
      widthTransformer(dividedBy: dividedBy, reducedBy: reducedByW);

  ///Returns Orientation using [MediaQuery]
  Orientation get orientation => mq.orientation;

  /// Returns if Orientation is landscape
  bool get isLandscape => orientation == Orientation.landscape;

  /// True if width be larger than 800
  bool get canShowNavRail => screenWidth > 800;

  /// theme of the app
  ThemeData get theme => Theme.of(this);

  /// color scheme of the app
  ColorScheme get colorScheme => theme.colorScheme;

  /// text themes of the app
  TextTheme get textTheme => theme.textTheme;

  /// Get the current locale of the app
  Locale get locale => Localizations.localeOf(this);

  /// Get the current locale name
  String get localeName => locale.toLanguageTag();
}

extension ThemeExtensions on BuildContext {
  Color get reversedBackground => switch (theme.brightness) {
    Brightness.dark => Colors.white,
    Brightness.light => const Color(0xFF282828),
  };
  Color get fillColor => switch (theme.brightness) {
    Brightness.dark => const Color(0xFF3f3f3f),
    Brightness.light => $styles.colors.softPink,
  };
  Color get backgroundColor => switch (theme.brightness) {
    Brightness.dark => const Color(0xFF282828),
    Brightness.light => $styles.colors.softPink,
  };
  Color get borderColor => switch (theme.brightness) {
    Brightness.dark => const Color(0xFF1D1D1D),
    Brightness.light => $styles.colors.borderColor,
  };
}

extension RiverpodContext on BuildContext {
  T read<T>(ProviderListenable<T> provider) {
    return ProviderScope.containerOf(this, listen: false).read(provider);
  }

  T watch<T>(ProviderListenable<T> provider) {
    return ProviderScope.containerOf(this).read(provider);
  }
}
