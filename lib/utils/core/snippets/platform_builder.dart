import 'package:flutter/foundation.dart';

/// Builder method to return a value based on the platform
///
/// [T] is the type of the value to be returned
T platformBuilder<T>({
  required T androidValue,
  required T iosValue,
  T? otherValue,
}) {
  final platform = defaultTargetPlatform;
  return switch (platform) {
    TargetPlatform.android => androidValue,
    TargetPlatform.iOS || TargetPlatform.macOS => iosValue,
    _ => otherValue ?? iosValue
  };
}
