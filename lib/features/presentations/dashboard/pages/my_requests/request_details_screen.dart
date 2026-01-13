import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import '../../../../../constant/styles.dart';
import '../../../../../providers.dart';
import '../../../../../utils/core/extensions/extensions_export.dart';
import '../../../../../widgets/forms/submit_button.dart';
import '../../../external/leave_request_form/data/leave_request_data.dart';
import '../../../external/leave_request_form/utils/enums/request_status.dart';
import 'widgets/quick_info_tile.dart';
import 'widgets/status_bade.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({
    super.key,
    required this.request,
    required this.onStatusChanged,
  });

  final LeaveRequestData request;
  final Function(RequestStatus) onStatusChanged;

  @override
  Widget build(BuildContext context) {
    final appLocalization = context.read(appLocalizationProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate('request_details')),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              Gap($styles.insets.md),
              Container(
                padding: EdgeInsets.all($styles.insets.md),
                height: 85,
                width: 85,
                decoration: BoxDecoration(
                  color: $styles.colors.softPink,
                  shape: BoxShape.circle,
                  boxShadow: $styles.shadows.cardShadow,
                ),
                child: Icon(
                  Icons.calendar_month_outlined,
                  color: $styles.colors.accent1,
                  size: 35,
                ),
              ),
              Gap($styles.insets.md),
              Text(
                request.leaveRequestData.nameByLocale(appLocalization.isAr),
                style: context.textTheme.titleMedium,
              ),
              Gap($styles.insets.xs),
              StatusBade(status: request.status),
              Gap($styles.insets.md),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all($styles.insets.md),
                decoration: BoxDecoration(
                  color: context.theme.cardColor,
                  borderRadius: BorderRadius.circular($styles.corners.nm),
                  border: Border.all(
                    color: $styles.colors.borderColor,
                    width: .5,
                  ),
                  boxShadow: $styles.shadows.softShadow,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Container(
                        padding: EdgeInsets.all($styles.insets.xs),
                        decoration: BoxDecoration(
                          color: $styles.colors.blueLink.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.info_sharp,
                          color: $styles.colors.blueLink,
                        ),
                      ),
                      title: Text(context.translate('leave_information')),
                      subtitle: Text(
                        context.translate('full_summary_description'),
                        style: context.textTheme.bodySmall,
                      ),
                    ),
                    const Divider().animate().scaleX(),
                    Gap($styles.insets.md),
                    QuickInfoTile(
                      icon: Icons.calendar_month_outlined,
                      title: context.translate('start_date'),
                      value: request.startDate.formatDate('dd MMM yyyy hh:mm'),
                    ),
                    QuickInfoTile(
                      icon: Icons.calendar_month_outlined,
                      title: context.translate('end_date'),
                      value: request.endDate.formatDate('dd MMM yyyy hh:mm'),
                    ),
                    QuickInfoTile(
                      icon: Icons.timer,
                      title: context.translate('duration'),
                      value: context.translate(
                        'days',
                        args: {'count': int.tryParse(request.days)},
                        count: int.tryParse(request.days),
                      ),
                    ),
                    QuickInfoTile(
                      icon: Icons.person,
                      title: context.translate('delegate_during_leave'),
                      value: request.delegateDuringLeave.nameByLocale(
                        appLocalization.isAr,
                      ),
                    ),
                    Gap($styles.insets.md),
                    const Divider().animate().scaleX(),
                    Gap($styles.insets.xs),
                    Text(
                      context.translate('notes'),
                      style: context.textTheme.bodyMedium,
                    ),
                    Text(
                      request.notes ?? context.translate('no_notes'),
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ).paddingHV(h: $styles.insets.md),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: $styles.insets.xs,
        children: [
          SubmitButton(
            onPressed: () {
              onStatusChanged(RequestStatus.approved);
            },
            title: context.translate('approve_request'),
            backgroundColor: $styles.colors.green,
            textColor: $styles.colors.greyStrong,
            fontWeight: FontWeight.bold,
          ),
          SubmitButton(
            onPressed: () {
              onStatusChanged(RequestStatus.rejected);
            },
            title: context.translate('reject_request'),
            backgroundColor: $styles.colors.red,
            fontWeight: FontWeight.bold,
          ),
        ],
      ).paddingAll($styles.insets.md),
    );
  }
}
