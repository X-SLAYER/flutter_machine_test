import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../../constant/styles.dart';
import '../../../../../providers.dart';
import '../../../../../utils/core/extensions/extensions_export.dart';
import '../../../../../widgets/bottom_sheets/bottom_sheet_helper.dart';
import 'widgets/language_selector.dart';
import 'widgets/theme_selector.dart';
import 'widgets/user_avatar_widget.dart';

class UserSettingsPage extends ConsumerWidget {
  const UserSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(appThemeProvider);
    final languageProvider = ref.watch(appLocalizationProvider);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Gap($styles.insets.md),
              const UserAvatarWidget(),
              Gap($styles.insets.sm),
              Text(
                'Ehab Briki',
                style: context.textTheme.titleLarge,
              ),
              Gap($styles.insets.xxs),
              Text(
                context.translate('software_engineer'),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: $styles.colors.greyMedium,
                ),
              ),
              Gap($styles.insets.xxs),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: $styles.insets.sm,
                  vertical: $styles.insets.xs,
                ),
                decoration: BoxDecoration(
                  color: $styles.colors.softPink,
                  borderRadius: BorderRadius.circular($styles.corners.nm),
                ),
                child: Text(
                  context.translate('employee_id', args: {'id': '404'}),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: $styles.colors.greyMedium,
                  ),
                ),
              ),
              Gap($styles.insets.xxl),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  context.translate('preferences').toUpperCase(),
                  style: context.textTheme.bodySmall,
                ),
              ),
              Gap($styles.insets.xs),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all($styles.insets.sm),
                decoration: BoxDecoration(
                  color: context.theme.cardColor,
                  borderRadius: BorderRadius.circular($styles.corners.lg),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      onTap: () {
                        AppBottomSheet.showActionDialog(
                          child: const LanguageSelector(),
                        );
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.language),
                      title: Text(
                        context.translate('language'),
                      ),
                      subtitle: Text(
                        context.translate(
                          languageProvider.languageType,
                        ),
                        style: context.textTheme.bodySmall,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                    Divider(
                      color: $styles.colors.greyLight,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.color_lens),
                      onTap: () {
                        AppBottomSheet.showActionDialog(
                          child: const ThemeSelector(),
                        );
                      },
                      title: Text(
                        context.translate('app_theme'),
                      ),
                      subtitle: Text(
                        context.translate(themeProvider.themeType),
                        style: context.textTheme.bodySmall,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ).paddingHV(h: $styles.insets.md),
        ),
      ),
    );
  }
}
