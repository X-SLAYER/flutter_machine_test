import 'package:flutter/material.dart';

import '../../../../../../constant/assets.dart';
import '../../../../../../constant/styles.dart';
import '../../../../../../utils/core/extensions/extensions_export.dart';
import '../../../../../../widgets/common/svg_icon.dart';

class EmployeeMainCard extends StatelessWidget {
  const EmployeeMainCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all($styles.insets.md),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular($styles.corners.nm),
        gradient: LinearGradient(
          colors: [
            $styles.colors.accent1,
            $styles.colors.accent1.withValues(alpha: .8),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: $styles.insets.xs,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgIcon(
            Assets.handShake,
            size: 40.0,
            color: $styles.colors.white,
          ),
          Text(
            context.translate('welcome_back'),
            style: context.textTheme.titleLarge?.copyWith(
              color: $styles.colors.white,
            ),
          ),
          Text(
            context.translate('manage_your_requests'),
            style: context.textTheme.bodySmall?.copyWith(
              color: $styles.colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
