import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../constant/styles.dart';
import '../../../providers.dart';
import '../../../utils/core/extensions/extensions_export.dart';
import '../invalid_feedback.dart';
import 'field.dart';
import 'form_field.dart';

class EntryDateField extends ConsumerWidget {
  final Function(DateTime)? onDateSelected;
  final VoidCallback onClearSelection;
  final bool isRequired;
  final bool showIcon;
  final String? error;
  final String? title;
  final DateTime? lastDate;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? defaultValue;
  final bool withMargin;
  final bool alwaysEnabled;
  final bool readOnly;
  final String? hint;
  final DateTimeFieldPickerMode mode;

  const EntryDateField({
    super.key,
    this.onDateSelected,
    this.isRequired = false,
    this.withMargin = true,
    this.error,
    this.title,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.defaultValue,
    this.hint = 'dd-mm-yyyy hh.mm',
    this.alwaysEnabled = false,
    this.showIcon = true,
    this.readOnly = false,
    this.mode = DateTimeFieldPickerMode.dateAndTime,
    required this.onClearSelection,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = ref.watch(appLocalizationProvider);

    return Container(
      margin: withMargin
          ? EdgeInsets.symmetric(vertical: $styles.insets.xs)
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title ?? '',
                  style: context.textTheme.bodyMedium!.copyWith(fontSize: 12.0),
                ).paddingHV(h: $styles.insets.xxs),
                Text(
                  '*',
                  style: TextStyle(
                    color: $styles.colors.accent2,
                    fontWeight: FontWeight.bold,
                  ),
                ).visibleWhen(isRequired),
              ],
            ),
            Gap($styles.insets.xs),
          ],
          DateTimeFormField(
            key: UniqueKey(),
            mode: mode,
            dateFormat: mode == DateTimeFieldPickerMode.dateAndTime
                ? DateFormat(localization.dateTimeFormat)
                : DateFormat(localization.dateFormat),
            lastDate: lastDate,
            initialDate: initialDate,
            firstDate: firstDate,
            initialValue: defaultValue,
            enabled: !readOnly,
            dateTextStyle: const TextStyle(fontSize: 13.0),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 13.0,
              ),
              labelStyle: TextStyle(
                color: $styles.colors.greyMedium,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: hint,
              hintStyle: context.textTheme.bodySmall,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: alwaysEnabled
                      ? $styles.colors.greyMedium
                      : Colors.transparent,
                  width: 1.8,
                ),
                borderRadius: BorderRadius.circular($styles.corners.nm),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: alwaysEnabled
                      ? $styles.colors.greyMedium
                      : Colors.transparent,
                  width: 1.8,
                ),
                borderRadius: BorderRadius.circular($styles.corners.nm),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: alwaysEnabled
                      ? $styles.colors.greyMedium
                      : Colors.transparent,
                  width: 1.8,
                ),
                borderRadius: BorderRadius.circular($styles.corners.nm),
              ),
              fillColor: readOnly ? context.borderColor : context.fillColor,
              filled: true,
              isDense: false,
              iconColor: Theme.of(context).colorScheme.secondary,
              focusColor: Theme.of(context).colorScheme.secondary,
              suffix: InkWell(
                onTap: onClearSelection,
                child: const Icon(Icons.clear, size: 16.0, color: Colors.red),
              ),
              prefixIcon: showIcon
                  ? const Icon(CupertinoIcons.calendar, size: 20)
                  : null,
            ),
            autovalidateMode: AutovalidateMode.always,
            onDateSelected: onDateSelected,
          ),
          Gap($styles.insets.xs),
          InvalidFeedBack(error),
        ],
      ),
    );
  }
}
