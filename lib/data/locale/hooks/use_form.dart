import 'package:ez_validator/ez_validator.dart';

import '../../../utils/core/extensions/extensions_export.dart';

class UseForm {
  EzSchema? schemaResolver;

  UseForm({this.schemaResolver});

  Map<dynamic, dynamic> _form = {};

  bool get hasError => result.hasError;
  bool get hasNoError => !hasError;
  Map<dynamic, dynamic> get ref => _form;
  Map<dynamic, dynamic> get data => result.form;
  Map<dynamic, dynamic> get errors => result.errors;

  Map<dynamic, dynamic> get nestedRef => ref.nestMap;
  Map<dynamic, dynamic> get nestedData => data.nestMap;
  Map<dynamic, dynamic> get nestedErrors => errors.nestMap;

  String? errorObj(String fullKey) {
    try {
      final keys = fullKey.split('.');
      var currentLevel = nestedErrors;

      for (final String key in keys) {
        if (currentLevel.containsKey(key)) {
          if (key == keys.last) {
            return currentLevel[key].toString();
          }
          currentLevel = currentLevel[key];
        } else {
          return null;
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  UseFormResult result = UseFormResult(
    errors: {},
    form: {},
    hasError: false,
  );

  void setDefaultValues(Map<dynamic, dynamic> defaultValues) {
    _form = defaultValues;
    result = UseFormResult(
      errors: {},
      form: _form,
      hasError: false,
    );
  }

  void setLateSchema(EzSchema? schema) {
    schemaResolver = schema;
  }

  void register(String name, dynamic value) {
    _form[name] = value;
  }

  void handleSumbitByField(String field) {
    if (schemaResolver == null || schemaResolver?[field] == null) {
      result = UseFormResult(
        hasError: false,
        errors: {},
        form: _form,
      );
      return;
    }
    final validator = schemaResolver![field] as EzValidator;
    final String? error = validator.build()(_form[field]);
    result = UseFormResult(
      hasError: error != null,
      errors: {
        ...errors,
        field: error,
      },
      form: _form,
    );
  }

  void clearError(String name) {
    if (result.errors.containsKey(name)) {
      result.errors.remove(name);
    }
  }

  void drop(String name) {
    _form.remove(name);
  }

  void registerArray(List<String> names, dynamic value) {
    _form[names.join('.')] = value;
  }

  void dropArray(List<String> names) {
    _form.remove(names.join('.'));
  }

  void reset() {
    _form = {};
    result = UseFormResult(
      errors: {},
      form: {},
      hasError: false,
    );
  }

  void handleSumbit() {
    if (schemaResolver == null) {
      result = UseFormResult(
        hasError: false,
        errors: {},
        form: _form,
      );
      return;
    }
    final (data, errors) = schemaResolver!.validateSync(_form);
    result = UseFormResult(
      hasError: schemaResolver != null && errors.isNotEmpty,
      errors: schemaResolver == null ? {} : errors,
      form: data,
    );
  }
}

class UseFormResult {
  final bool hasError;
  final Map<dynamic, dynamic> errors;
  final Map<dynamic, dynamic> form;

  UseFormResult({
    required this.hasError,
    required this.errors,
    required this.form,
  });

  @override
  String toString() {
    return '$hasError\n$errors\n$form';
  }
}
