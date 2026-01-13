import 'package:flutter/material.dart';

import '../../constant/styles.dart';
import '../../data/locale/general_context.dart';
import '../../utils/core/extensions/extensions_export.dart';
import 'sheet_action_item.dart';

class AppBottomSheet {
  const AppBottomSheet._();

  static void showActionDialog({
    required Widget child,
    bool isExpanded = false,
    bool isScrollController = true,
    VoidCallback? whenComplete,
  }) {
    showModalBottomSheet(
      elevation: 0.0,
      context: $appContext.navigatorContext,
      backgroundColor: Colors.transparent,
      isScrollControlled: isScrollController,
      isDismissible: false,
      useSafeArea: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, StateSetter stateSetter) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              decoration: BoxDecoration(
                color:
                    $appContext.navigatorContext.theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular($styles.corners.lg),
                  topRight: Radius.circular($styles.corners.lg),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  if (isExpanded)
                    Expanded(child: child.paddingAll($styles.insets.sm))
                  else
                    child.paddingAll($styles.insets.sm),
                ],
              ),
            ),
          ),
        );
      },
    ).whenComplete(() {
      if (whenComplete != null) {
        whenComplete();
      }
    });
  }

  static Future<void> showActions(
    String? title,
    List<SheetActionItem> actions,
  ) async {
    showModalBottomSheet(
      elevation: 0.0,
      context: $appContext.navigatorContext,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      useSafeArea: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, StateSetter stateSetter) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              decoration: BoxDecoration(
                color: $styles.colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular($styles.corners.sm),
                  topRight: Radius.circular($styles.corners.sm),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (title == null)
                        const SizedBox.shrink()
                      else
                        Text(
                          title,
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ).paddingHV(h: $styles.insets.sm),
                  const Divider(),
                  ...actions.map((e) => e.paddingHV(h: $styles.insets.sm)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<dynamic> showWidgetSheet({
    required Widget child,
  }) async {
    return showModalBottomSheet(
      backgroundColor:
          $appContext.navigatorContext.theme.scaffoldBackgroundColor,
      barrierColor: Colors.black.withValues(alpha: 0.45),
      elevation: 0.0,
      context: $appContext.navigatorContext,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(
                $appContext.navigatorContext,
              ).viewInsets.bottom,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular($styles.insets.sm),
                  topRight: Radius.circular($styles.insets.sm),
                ),
              ),
              child: child,
            ).withNoGlowBehaviour(),
          ),
        );
      },
    );
  }
}
