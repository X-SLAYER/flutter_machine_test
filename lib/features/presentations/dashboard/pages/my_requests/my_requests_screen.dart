import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import '../../../../../constant/styles.dart';
import '../../../../../utils/app_utils/system_manager.dart';
import '../../../../../utils/core/extensions/extensions_export.dart';
import '../../../../../widgets/no_data.dart';
import '../../../../view_models/base_main.dart';
import 'my_requests_view_model.dart';
import 'request_details_screen.dart';
import 'widgets/request_tile.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModel<MyRequestsViewModel>(
      model: MyRequestsViewModel(),
      onInitState: (viewModel) {
        viewModel.loadRequests();
      },
      builder: (viewModel) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.translate('my_requests')),
          ),
          body: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : viewModel.requests.isEmpty
              ? Center(
                  child: NoData(
                    message: context.translate('no_requests'),
                  ),
                )
              : ListView.separated(
                  itemCount: viewModel.requests.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    final request = viewModel.requests[index];
                    return RequestTile(
                      request: request,
                      onTap: () {
                        pushRevealScreen(
                          RequestDetailsScreen(
                            request: request,
                            onStatusChanged: (status) {
                              Navigator.pop(context);
                              viewModel.changeRequestStatus(request.id, status);
                            },
                          ),
                        );
                      },
                    ).animate().fadeIn(duration: (index * 200).ms).moveX();
                  },
                  separatorBuilder: (_, _) => Gap($styles.insets.sm),
                ).paddingHV(h: $styles.insets.sm, v: $styles.insets.md),
        );
      },
    );
  }
}
