import 'package:flutter/material.dart';

import '../../../../../../constant/styles.dart';
import '../../../../../../utils/core/extensions/extensions_export.dart';
import '../../../../external/leave_request_form/utils/enums/request_status.dart';

class StatusBade extends StatelessWidget {
  const StatusBade({super.key, required this.status});

  final RequestStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: $styles.insets.sm,
        vertical: $styles.insets.xxs,
      ),
      decoration: BoxDecoration(
        color: status.color,
        borderRadius: BorderRadius.circular($styles.corners.nm),
      ),
      child: Text(
        context.translate(status),
        style: context.textTheme.bodySmall?.copyWith(
          color: status.darkColor,
          fontWeight: FontWeight.bold,
          shadows: $styles.shadows.textSoft,
        ),
      ),
    );
  }
}
