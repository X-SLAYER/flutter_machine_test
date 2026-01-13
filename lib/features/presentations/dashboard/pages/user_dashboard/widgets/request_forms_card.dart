import 'package:flutter/material.dart';

import '../../../../../../constant/styles.dart';
import '../../../../../../utils/core/extensions/extensions_export.dart';
import '../../../../../../widgets/common/svg_icon.dart';
import 'comming_soon_badge.dart';

class RequestFormsCard extends StatelessWidget {
  const RequestFormsCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.svgIcon,
    required this.onTap,
    this.comingSoon = false,
  });

  final String title;
  final String subtitle;
  final String svgIcon;
  final VoidCallback onTap;
  final bool comingSoon;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular($styles.corners.nm),
          splashColor: $styles.colors.accent1.withValues(alpha: 0.1),
          onTap: onTap,
          child: Ink(
            padding: EdgeInsets.symmetric(
              vertical: $styles.insets.xs,
              horizontal: $styles.insets.sm,
            ),
            decoration: BoxDecoration(
              color: context.theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular($styles.corners.nm),
              boxShadow: [
                BoxShadow(
                  color: $styles.colors.greyMedium.withValues(alpha: 0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                height: 40,
                width: 40,
                padding: EdgeInsets.all($styles.insets.xs),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular($styles.corners.nm),
                  border: Border.all(
                    color: $styles.colors.body.withValues(alpha: 0.2),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      $styles.colors.accent1.withValues(alpha: 0.4),
                      $styles.colors.accent1.withValues(alpha: 0.2),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: SvgIcon(
                    svgIcon,
                    color: context.theme.iconTheme.color,
                  ),
                ),
              ),
              title: Text(title),
              subtitle: Text(
                subtitle,
                style: context.textTheme.bodySmall,
              ),
            ),
          ),
        ),
        if (comingSoon)
          const PositionedDirectional(
            top: -5,
            end: -5,
            child: CommingSoonBadge(),
          ),
      ],
    );
  }
}
