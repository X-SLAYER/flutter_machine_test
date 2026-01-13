import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../constant/styles.dart';
import '../../utils/core/extensions/extensions_export.dart';
import 'invalid_feedback.dart';

class DropDownField<T> extends StatelessWidget {
  final String hint;
  final String? title;
  final T value;
  final ValueChanged<T> onChanged;
  final List<DropdownMenuItem<T>>? items;
  final bool isRequired;
  final String? error;
  final bool readOnly;
  final bool isDense;
  final bool isOptional;

  const DropDownField({
    super.key,
    this.title,
    required this.hint,
    required this.value,
    required this.onChanged,
    required this.items,
    this.isRequired = false,
    this.error,
    this.readOnly = false,
    this.isDense = true,
    this.isOptional = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title ?? ''),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(
                  color: $styles.colors.accent2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (isOptional) ...[
              Gap($styles.insets.xxs),
              Text(
                '(${context.translate('optional')})',
                style: context.textTheme.bodySmall?.copyWith(
                  color: $styles.colors.greyMedium,
                ),
              ),
            ],
          ],
        ).visibleWhen(title != null),
        Gap($styles.insets.xs).visibleWhen(title != null),
        Container(
          padding: EdgeInsets.symmetric(vertical: $styles.insets.xs),
          decoration: BoxDecoration(
            color: readOnly ? context.borderColor : context.fillColor,
            borderRadius: BorderRadius.circular($styles.corners.nm),
            border: Border.all(
              width: error == null || error!.isEmpty ? 1 : 1.8,
              color: (error == null || error!.isEmpty)
                  ? context.borderColor
                  : $styles.colors.red,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              padding: EdgeInsets.symmetric(
                horizontal: $styles.insets.xs,
                vertical: 2,
              ),
              isDense: isDense,
              hint: Text(
                hint,
                style: const TextStyle(
                  fontSize: 13.0,
                ),
              ),
              style: context.textTheme.bodySmall,
              value: value,
              onChanged: (value) {
                onChanged(value as T);
              },
              isExpanded: true,
              items: items,
            ),
          ),
        ),
        if (error != null && error!.isNotEmpty) ...[
          Gap($styles.insets.xs),
          InvalidFeedBack(error),
          Gap($styles.insets.xs),
        ],
      ],
    );
  }
}
