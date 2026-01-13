import 'package:flutter/material.dart';

import '../../../../../../constant/assets.dart';
import '../../../../../../constant/styles.dart';
import '../../../../../../utils/core/extensions/extensions_export.dart';
import '../../../../../../widgets/common/svg_icon.dart';

class CommingSoonBadge extends StatelessWidget {
  const CommingSoonBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: $styles.insets.xs,
        vertical: $styles.insets.xxs,
      ),
      decoration: BoxDecoration(
        color: $styles.colors.softPink,
        border: Border.all(
          color: $styles.colors.accent1.withValues(alpha: 0.1),
        ),
        borderRadius: BorderRadius.circular($styles.corners.nm),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
              child: SvgIcon(
                Assets.handShake,
                color: $styles.colors.black,
                size: 16.0,
              ),
            ),
            const TextSpan(text: ' '),
            TextSpan(
              text: context.translate('coming_soon'),
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: $styles.colors.black,
                fontSize: 10.0,
                shadows: $styles.shadows.textSoft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
