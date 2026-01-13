import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import '../../../../../constant/styles.dart';
import '../../../../../utils/animations/route_transation.dart';
import '../../../../../utils/app_utils/system_manager.dart';
import '../../../../../utils/core/extensions/extensions_export.dart';
import '../../../../../widgets/modals/app_modals.dart';
import '../../../external/leave_request_form/leave_request_form_screen.dart';
import '../../utils/enums/request_forms_type.dart';
import 'widgets/employee_main_card.dart';
import 'widgets/request_forms_card.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate('employee_requests')),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap($styles.insets.sm),
            const EmployeeMainCard().animate().shimmer(
              duration: $styles.times.med,
            ),
            Gap($styles.insets.md),
            Text(
              context.translate('request_forms'),
              style: context.textTheme.titleMedium,
            ),
            Gap($styles.insets.md),
            ...RequestFormsType.values
                .map(
                  (e) => RequestFormsCard(
                    title: context.translate(e),
                    subtitle: context.translate(
                      'RequestFormsTypeDescription.${e.name}',
                    ),
                    svgIcon: e.icon,
                    comingSoon: e.isComingSoon,
                    onTap: () {
                      if (e.isComingSoon) {
                        Modals.success(
                          context,
                          context.translate(
                            'feature_coming_soon',
                            args: {
                              'feature': context.translate(e),
                            },
                          ),
                        );
                      } else {
                        pushScreenWithTransitions(
                          const LeaveRequestFormScreen(),
                          AnimationType.slideLeft,
                        );
                      }
                    },
                  ),
                )
                .toList()
                .gap($styles.insets.md),
            Gap($styles.insets.md),
          ],
        ).paddingHV(h: $styles.insets.sm),
      ),
    );
  }
}
