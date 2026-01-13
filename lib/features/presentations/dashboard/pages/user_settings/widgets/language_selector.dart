import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../../../constant/shared_prefences.dart';
import '../../../../../../constant/styles.dart';
import '../../../../../../data/locale/shared_prefs_handler.dart';
import '../../../../../../providers.dart';
import '../../../../../../stores/language/language_types.dart';
import '../../../../../../utils/core/extensions/extensions_export.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, _) {
        final languageProvider = ref.watch(appLocalizationProvider);
        return SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.translate('select_language'),
                style: context.textTheme.bodyMedium,
              ),
              const Divider(),
              Gap($styles.insets.sm),
              ...LanguageTypes.values
                  .map(
                    (e) => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: $styles.insets.sm,
                        vertical: $styles.insets.xs,
                      ),
                      decoration: BoxDecoration(
                        color: languageProvider.languageType == e
                            ? $styles.colors.accent1.withValues(alpha: 0.4)
                            : null,
                        borderRadius: BorderRadius.circular($styles.corners.lg),
                      ),
                      child: ListTile(
                        onTap: () {
                          languageProvider.toggleLocal(e);
                          SharedPrefsHandler.storeValue(
                            SharedPrefsKeys.language,
                            e.localeName,
                          );
                        },
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(e.icon, width: 40, height: 40),
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
