import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../constant/styles.dart';
import '../../../../../../providers.dart';
import '../../../../../../utils/core/extensions/extensions_export.dart';
import '../../../../external/leave_request_form/data/leave_request_data.dart';
import 'status_bade.dart';

class RequestTile extends StatelessWidget {
  const RequestTile({super.key, required this.request, required this.onTap});

  final LeaveRequestData request;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final appLocalization = context.read(appLocalizationProvider);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular($styles.corners.lg),
        onTap: onTap,
        child: Ink(
          padding: EdgeInsets.symmetric(
            horizontal: $styles.insets.sm,
            vertical: $styles.insets.sm,
          ),
          decoration: BoxDecoration(
            color: context.theme.cardColor,
            borderRadius: BorderRadius.circular($styles.corners.lg),
            border: Border.all(
              color: $styles.colors.borderColor,
              width: .5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  request.leaveRequestData.nameByLocale(appLocalization.isAr),
                ),
                subtitle: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: $styles.insets.xs,
                  children: [
                    Text(
                      request.startEndDate,
                      style: context.textTheme.bodySmall,
                    ),
                    Text(
                      '● ${context.translate('days', args: {'count': int.tryParse(request.days)}, count: int.tryParse(request.days))}',
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
                trailing: StatusBade(status: request.status),
              ),
              Gap($styles.insets.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.translate('tap_to_view_details'),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: $styles.colors.blueLink,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: $styles.colors.blueLink,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
