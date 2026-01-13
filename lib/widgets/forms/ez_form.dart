import 'package:ez_validator/ez_validator.dart';
import 'package:flutter/material.dart';
import '../../data/locale/hooks/use_form.dart';

typedef EzBuilder = Widget Function(BuildContext context, UseForm useForm);

class EzForm extends StatefulWidget {
  final EzSchema? schema;
  final EzFormController controller;
  final EzBuilder builder;
  final Map<dynamic, dynamic>? defaultValues;
  final bool isLazy;
  final bool validateAfterFirstSubmit;

  const EzForm({
    super.key,
    this.schema,
    required this.controller,
    required this.builder,
    this.defaultValues,
    this.isLazy = false,
    this.validateAfterFirstSubmit = false,
  });

  @override
  EzFormState createState() => EzFormState();
}

class EzFormState extends State<EzForm> {
  late UseForm useForm;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    useForm = UseForm(schemaResolver: widget.schema);
    if (widget.defaultValues != null) {
      useForm.setDefaultValues(widget.defaultValues!);
    }
    widget.controller.set(this);
  }

  void _forceRebuild() {
    setState(() {});
    _counter += 1;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, useForm);
  }
}

class EzFormController {
  late EzFormState _ezFormState;

  void set(EzFormState ezFormState) {
    _ezFormState = ezFormState;
  }

  bool validate() {
    if (_ezFormState.widget.isLazy) {
      _ezFormState.useForm.setLateSchema(_ezFormState.widget.schema);
    }
    _ezFormState.useForm.handleSumbit();
    _ezFormState._forceRebuild();
    return isValid;
  }

  void register(String name, dynamic value) {
    _ezFormState.useForm.register(name, value);
  }

  void validateRegister(String name, dynamic value) {
    register(name, value);
    if (_ezFormState.widget.validateAfterFirstSubmit) {
      if (_ezFormState._counter > 0) {
        _validateByField(name);
      }
      return;
    }
    _validateByField(name);
  }

  void cleanRegister(String name, dynamic value) {
    register(name, value);
    _ezFormState.useForm.clearError(name);
    _ezFormState._forceRebuild();
  }

  bool _validateByField(String field) {
    _ezFormState.useForm.handleSumbitByField(field);
    _ezFormState._forceRebuild();
    return isValid;
  }

  bool get isValid => _ezFormState.useForm.hasNoError;
  Map<dynamic, dynamic> get data => _ezFormState.useForm.data;
  Map<dynamic, dynamic> get ref => _ezFormState.useForm.ref;
  Map<dynamic, dynamic> get nestedData => _ezFormState.useForm.nestedData;
  Map<dynamic, dynamic> get errors => _ezFormState.useForm.errors;
  Map<dynamic, dynamic> get nestedErrors => _ezFormState.useForm.nestedErrors;
}
