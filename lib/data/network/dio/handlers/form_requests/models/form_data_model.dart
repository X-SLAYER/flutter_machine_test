import 'package:equatable/equatable.dart';

import '../../../common/xnetwork_model.dart';
import '../enums/field_type.dart';

class FormDataModel extends XNetworkModel<FormDataModel> {
  final num? id;
  final String? nameEn;
  final String? nameAr;
  final List<FormSection>? formSections;

  FormDataModel({
    this.id,
    this.nameEn,
    this.nameAr,
    this.formSections,
  });

  FormDataModel copyWith({
    num? id,
    String? nameEn,
    String? nameAr,
    List<FormSection>? formSections,
  }) => FormDataModel(
    id: id ?? this.id,
    nameEn: nameEn ?? this.nameEn,
    nameAr: nameAr ?? this.nameAr,
    formSections: formSections ?? this.formSections,
  );

  factory FormDataModel.fromJson(Map<String, dynamic> json) => FormDataModel(
    id: json['id'],
    nameEn: json['nameEn'],
    nameAr: json['nameAr'],
    formSections: json['formSections'] == null
        ? []
        : List<FormSection>.from(
            json['formSections']!.map((x) => FormSection.fromJson(x)),
          ),
  );

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'nameEn': nameEn,
    'nameAr': nameAr,
    'formSections': formSections == null
        ? []
        : List<dynamic>.from(formSections!.map((x) => x.toJson())),
  };

  @override
  FormDataModel fromJson(Map<String, dynamic> json) =>
      FormDataModel.fromJson(json);
}

class FormSection extends Equatable {
  final num? id;
  final String? labelEn;
  final String? labelAr;
  final num? type;
  final String? fieldMapping;
  final String? apiUrl;
  final bool? isRequired;
  final bool? isReadOnly;
  final List<InputFieldValidation>? inputFieldValidations;
  final bool? isActive;

  FieldType get fieldType =>
      FieldType.values.firstWhere((element) => element.value == type);

  const FormSection({
    this.id,
    this.labelEn,
    this.labelAr,
    this.type,
    this.fieldMapping,
    this.apiUrl,
    this.isRequired,
    this.isReadOnly,
    this.inputFieldValidations,
    this.isActive,
  });

  String labelByLocale(bool isAr) =>
      isAr ? labelAr ?? labelEn ?? '' : labelEn ?? labelAr ?? '';

  FormSection copyWith({
    num? id,
    String? labelEn,
    String? labelAr,
    num? type,
    String? fieldMapping,
    String? apiUrl,
    bool? isRequired,
    bool? isReadOnly,
    List<InputFieldValidation>? inputFieldValidations,
    bool? isActive,
  }) => FormSection(
    id: id ?? this.id,
    labelEn: labelEn ?? this.labelEn,
    labelAr: labelAr ?? this.labelAr,
    type: type ?? this.type,
    fieldMapping: fieldMapping ?? this.fieldMapping,
    apiUrl: apiUrl ?? this.apiUrl,
    isRequired: isRequired ?? this.isRequired,
    isReadOnly: isReadOnly ?? this.isReadOnly,
    inputFieldValidations: inputFieldValidations ?? this.inputFieldValidations,
    isActive: isActive ?? this.isActive,
  );

  factory FormSection.fromJson(Map<String, dynamic> json) => FormSection(
    id: json['id'],
    labelEn: json['labelEn'],
    labelAr: json['labelAr'],
    type: json['type'],
    fieldMapping: json['fieldMapping'],
    apiUrl: json['apiUrl'],
    isRequired: json['isRequired'],
    isReadOnly: json['isReadOnly'],
    inputFieldValidations: json['inputFieldValidations'] == null
        ? []
        : List<InputFieldValidation>.from(
            json['inputFieldValidations']!.map(
              (x) => InputFieldValidation.fromJson(x),
            ),
          ),
    isActive: json['isActive'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'labelEn': labelEn,
    'labelAr': labelAr,
    'type': type,
    'fieldMapping': fieldMapping,
    'apiUrl': apiUrl,
    'isRequired': isRequired,
    'isReadOnly': isReadOnly,
    'inputFieldValidations': inputFieldValidations == null
        ? []
        : List<dynamic>.from(inputFieldValidations!.map((x) => x.toJson())),
    'isActive': isActive,
  };

  @override
  List<Object?> get props => [
    id,
    labelEn,
    labelAr,
    type,
    fieldMapping,
    apiUrl,
    isRequired,
    isReadOnly,
    inputFieldValidations,
    isActive,
  ];
}

class InputFieldValidation extends Equatable {
  final num? id;
  final String? validationType;
  final String? validationValue;
  final num? inputFieldId;

  const InputFieldValidation({
    this.id,
    this.validationType,
    this.validationValue,
    this.inputFieldId,
  });

  String get firstField => validationValue?.split(',').firstOrNull ?? '';
  String get secondField => validationValue?.split(',').lastOrNull ?? '';

  InputFieldValidation copyWith({
    num? id,
    String? validationType,
    String? validationValue,
    num? inputFieldId,
  }) => InputFieldValidation(
    id: id ?? this.id,
    validationType: validationType ?? this.validationType,
    validationValue: validationValue ?? this.validationValue,
    inputFieldId: inputFieldId ?? this.inputFieldId,
  );

  factory InputFieldValidation.fromJson(Map<String, dynamic> json) =>
      InputFieldValidation(
        id: json['id'],
        validationType: json['validationType'],
        validationValue: json['validationValue'],
        inputFieldId: json['inputFieldId'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'validationType': validationType,
    'validationValue': validationValue,
    'inputFieldId': inputFieldId,
  };

  @override
  List<Object?> get props => [
    id,
    validationType,
    validationValue,
    inputFieldId,
  ];
}
