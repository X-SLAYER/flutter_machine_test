import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../constant/styles.dart';
import '../../../../main.dart';
import '../../../../providers.dart';
import '../../../../utils/core/extensions/extensions_export.dart';
import '../../../../widgets/forms/ez_form.dart';
import '../../../../widgets/forms/submit_button.dart';
import '../../../../widgets/modals/app_modals.dart';
import '../../../view_models/base_main.dart';
import 'leave_form_view_model.dart';

class LeaveRequestFormScreen extends ConsumerWidget {
  const LeaveRequestFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageProvider = ref.watch(appLocalizationProvider);
    return ViewModel<LeaveFormViewModel>(
      model: LeaveFormViewModel(),
      onInitState: (viewModel) async {
        await viewModel.getFormData();
      },
      builder: (viewModel) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.translate('leave_request')),
          ),
          body: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : EzForm(
                  controller: viewModel.controller,
                  schema: viewModel.formEngine.generateSchema(
                    viewModel.formSections,
                  ),
                  builder: (_, useForm) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap($styles.insets.md),
                          ...viewModel.formEngine.generateFields(
                            models: viewModel.formSections,
                            defaultValues: viewModel.controller.ref,
                            errors: viewModel.controller.errors,
                            onChanged: viewModel.controller.cleanRegister,
                            dropDownValues: viewModel.dropDownValuesMap,
                            isAr: languageProvider.isAr,
                          ),
                        ],
                      ).paddingHV(h: $styles.insets.sm),
                    );
                  },
                ),
          bottomNavigationBar: SubmitButton(
            backgroundColor: $styles.colors.accent1,
            fontWeight: FontWeight.bold,
            onPressed: () {
              if (!viewModel.controller.validate()) {
                $logger.e(viewModel.controller.errors);
                return;
              } else {
                viewModel.storeDataLocally();
                Navigator.pop(context);
                Modals.success(
                  context,
                  context.translate('request_sent_successfully'),
                );
              }
            },
            title: context.translate('send_request'),
          ).paddingAll($styles.insets.md),
        );
      },
    );
  }
}
