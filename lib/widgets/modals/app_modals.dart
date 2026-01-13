import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../constant/styles.dart';

import '../../utils/core/extensions/extensions_export.dart';
import 'widgets/iosish.dart';

class Modals {
  Modals._();

  static const duration = Duration(milliseconds: 1800);

  static void success(BuildContext context, String message) {
    Iosish(context).createIndicator(
      title: message,
      duration: duration,
      child: const Icon(Icons.check_circle, color: Colors.green),
    );
  }

  static void error(BuildContext context, String message) {
    Iosish(context).createIndicator(
      title: message,
      duration: duration,
      child: const Icon(Icons.error_sharp, color: Colors.red),
    );
  }

  static void showLoadingDialog(BuildContext context, [String? message]) {
    showGeneralDialog(
      barrierColor: Colors.transparent,
      context: context,
      pageBuilder: (_, _, _) => Material(
        color: Colors.black.withValues(alpha: .35),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 25.0,
                  height: 25.0,
                  child: CircularProgressIndicator(
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Gap($styles.insets.xxs).visibleWhen(message != null),
                Text(message ?? '').visibleWhen(message != null),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
