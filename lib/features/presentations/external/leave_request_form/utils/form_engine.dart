import 'package:ez_validator/ez_validator.dart';
import 'package:flutter/material.dart';

import '../../../../../../constant/styles.dart';
import '../../../../../../utils/core/extensions/extensions_export.dart';
import '../../../../../../widgets/forms/entry_field.dart';
import '../../../../../data/network/dio/handlers/form_requests/enums/field_type.dart';
import '../../../../../data/network/dio/handlers/form_requests/models/form_data_model.dart';
import '../../../../../entities/drop_down_entity.dart';
import '../../../../../widgets/forms/date_field/entry_field_date.dart';
import '../../../../../widgets/forms/dropdown_field.dart';

class FormEngine {
  List<FormSection>? _allModels;

  void _triggerDependentCalculations(
    String changedField,
    dynamic newValue,
    Map<dynamic, dynamic> formValues,
    Function(String name, dynamic value)? onChanged,
  ) {
    if (_allModels == null) {
      return;
    }

    final helperMethods = {
      'CalculateDaysBetweenDates': calculateDaysBetweenDates,
    };

    final updatedFormValues = {...formValues, changedField: newValue};

    for (final model in _allModels!) {
      if (model.inputFieldValidations != null) {
        for (final validation in model.inputFieldValidations!) {
          if (validation.firstField == changedField ||
              validation.secondField == changedField) {
            if (helperMethods.containsKey(validation.validationType)) {
              final calculatedValue = helperMethods[validation.validationType]!(
                updatedFormValues[validation.firstField],
                updatedFormValues[validation.secondField],
              );
              onChanged?.call(model.fieldMapping!, calculatedValue);
            }
          }
        }
      }
    }
  }

  Widget generateField({
    required FormSection model,
    required final Function(String name, dynamic value)? onChanged,
    required Map<dynamic, dynamic> formValues,
    required List<DropDownEntity> dropDownValues,
    String? error,
    dynamic defaultValue,
    bool isAr = false,
  }) {
    final helperMethods = {
      'CalculateDaysBetweenDates': calculateDaysBetweenDates,
    };
    if (model.inputFieldValidations != null) {
      for (final validation in model.inputFieldValidations!) {
        if (helperMethods.containsKey(validation.validationType)) {
          onChanged?.call(
            model.fieldMapping!,
            helperMethods[validation.validationType]!(
              formValues[validation.firstField],
              formValues[validation.secondField],
            ),
          );
        }
      }
    }
    return switch (model.fieldType) {
      FieldType.text => EntryField(
        name: model.fieldMapping.toString(),
        title: model.labelByLocale(isAr),
        isRequired: model.isRequired ?? false,
        hint: model.labelByLocale(isAr),
        readOnly: model.isReadOnly ?? false,
        error: error,
        defaultValue: defaultValue,
        maxLines: model.fieldMapping == 'notes' ? 3 : 1,
        onChanged: (name, value) {
          onChanged?.call(name, value);
          _triggerDependentCalculations(name, value, formValues, onChanged);
        },
      ),
      FieldType.date => EntryDateField(
        title: model.labelByLocale(isAr),
        isRequired: model.isRequired ?? false,
        readOnly: model.isReadOnly ?? false,
        hint: model.labelByLocale(isAr),
        defaultValue: defaultValue,
        error: error,
        onClearSelection: () {
          onChanged?.call(model.fieldMapping.toString(), null);
          _triggerDependentCalculations(
            model.fieldMapping.toString(),
            null,
            formValues,
            onChanged,
          );
        },
        onDateSelected: (date) {
          onChanged?.call(
            model.fieldMapping.toString(),
            date,
          );
          _triggerDependentCalculations(
            model.fieldMapping.toString(),
            date,
            formValues,
            onChanged,
          );
        },
      ),
      FieldType.dropDown => DropDownField<DropDownEntity?>(
        title: model.labelByLocale(isAr),
        value: defaultValue,
        items: dropDownValues
            .map(
              (e) =>
                  DropdownMenuItem(value: e, child: Text(e.nameByLocale(isAr))),
            )
            .toList(),
        isRequired: model.isRequired ?? false,
        hint: model.labelByLocale(isAr),
        error: error,
        onChanged: (value) {
          onChanged?.call(model.fieldMapping!, value);
          _triggerDependentCalculations(
            model.fieldMapping!,
            value,
            formValues,
            onChanged,
          );
        },
      ),
    };
  }

  List<Widget> generateFields({
    required List<FormSection> models,
    required final Function(String name, dynamic value)? onChanged,
    required Map<String, List<DropDownEntity>> dropDownValues,
    Map<dynamic, dynamic>? errors,
    Map<dynamic, dynamic>? defaultValues,
    bool isAr = false,
  }) {
    _allModels = models;
    return models
        .map(
          (model) => generateField(
            model: model,
            onChanged: onChanged,
            error: errors?[model.fieldMapping],
            defaultValue: defaultValues?[model.fieldMapping],
            formValues: defaultValues ?? {},
            isAr: isAr,
            dropDownValues: dropDownValues[model.fieldMapping] ?? [],
          ),
        )
        .toList()
        .gap($styles.insets.xs);
  }

  // this is to generate dynamic validations
  // this package is developed by me to help
  // making the validation more easier inspired from (ZOD)
  EzValidator<dynamic> generateValidator(FormSection model) {
    return switch (model.fieldType) {
      FieldType.text => EzValidator<String>(
        optional: !(model.isRequired ?? false),
      ).required(),
      FieldType.date => EzValidator<DateTime>(
        optional: !(model.isRequired ?? false),
      ).required(),
      FieldType.dropDown => EzValidator(
        optional: !(model.isRequired ?? false),
      ).required(),
    };
  }

  EzSchema generateSchema(List<FormSection> models) {
    final schema = <String, EzValidator>{};
    for (final model in models) {
      schema[model.fieldMapping!] = generateValidator(model);
    }
    return EzSchema.shape(schema);
  }

  String calculateDaysBetweenDates(DateTime? start, DateTime? end) {
    if (start == null || end == null) {
      return '0';
    }
    if (end.isBefore(start)) {
      return '0';
    }
    return (end.difference(start).inDays + 1).toString();
  }
}
