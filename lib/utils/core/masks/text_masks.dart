import 'package:flutter/services.dart';

class TextInputFormatters {
  TextInputFormatters._();

  static final TextInputFormatter decimalAndNumbers =
      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'));
}
