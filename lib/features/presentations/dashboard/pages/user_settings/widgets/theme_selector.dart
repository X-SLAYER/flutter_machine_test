import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../../../constant/shared_prefences.dart';
import '../../../../../../constant/styles.dart';
import '../../../../../../data/locale/shared_prefs_handler.dart';
import '../../../../../../providers.dart';
import '../../../../../../stores/providers/app_theme.dart';
import '../../../../../../utils/core/extensions/extensions_export.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, _) {
        final themeProvider = ref.watch(appThemeProvider);
        return SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.translate('select_theme'),
                style: context.textTheme.bodyMedium,
              ),
              const Divider(),
              Gap($styles.insets.sm),
              ...ThemeStyle.values
                  .map(
                    (e) => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: $styles.insets.sm,
                        vertical: $styles.insets.xs,
                      ),
                      decoration: BoxDecoration(
                        color: themeProvider.themeType == e
                            ? $styles.colors.accent1.withValues(alpha: 0.4)
                            : null,
                        borderRadius: BorderRadius.circular($styles.corners.lg),
                      ),
                      child: ListTile(
                        onTap: () {
                          themeProvider.setThemeData(e);
                          SharedPrefsHandler.storeValue(
                            SharedPrefsKeys.appTheme,
                            e.name,
                          );
                        },
                        contentPadding: EdgeInsets.zero,
                        title: Text(context.translate(e)),
                      ),
                    ),
                  )
                  .toList()
                  .gap($styles.insets.xxs),
              Gap($styles.insets.md),
            ],
          ).paddingHV(h: $styles.insets.sm),
        );
      },
    );
  }
}
