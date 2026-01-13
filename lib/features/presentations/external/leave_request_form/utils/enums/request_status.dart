import 'package:flutter/material.dart';

import '../../../../../../constant/styles.dart';

enum RequestStatus {
  pending,
  approved,
  rejected;

  Color get color => switch (this) {
    pending => $styles.colors.warning,
    approved => $styles.colors.green.withValues(alpha: 0.1),
    rejected => $styles.colors.red.withValues(alpha: 0.1),
  };

  Color get darkColor => switch (this) {
    pending => $styles.colors.gold,
    approved => Colors.green,
    rejected => $styles.colors.red,
  };
}
