import 'package:ez_validator/ez_validator.dart';

class EnLocale implements EzLocale {
  const EnLocale();

  @override
  String get name => 'english';

  @override
  String minLength(String v, int n, [String? label]) =>
      'The field must be at least $n characters long';

  @override
  String maxLength(String v, int n, [String? label]) =>
      'The field must be at most $n characters long';

  @override
  String email(String v, [String? label]) =>
      'The field is not a valid email address';

  @override
  String phoneNumber(String v, [String? label]) =>
      'The field is not a valid phone number';

  @override
  String required([String? label]) => 'Field required.';

  @override
  String ip(String v, [String? label]) => 'The field is not a valid IP address';

  @override
  String ipv6(String v, [String? label]) =>
      'The field is not a valid IPv6 address';

  @override
  String url(String v, [String? label]) =>
      'The field is not a valid URL address';

  @override
  String boolean(String v, [String? label]) =>
      'The field is not a boolean type';

  @override
  String uuid(String v, [String? label]) => 'The field is not a valid uuid';

  @override
  String lowerCase(String v, [String? label]) =>
      'The field is not in lower case';

  @override
  String upperCase(String v, [String? label]) =>
      'The field is not in upper case';

  @override
  String notNumber(String v, [String? label]) =>
      'The field must not be a number';

  @override
  String number(String v, [String? label]) => 'The field is not a valid number';

  @override
  String matches(String pattern, String v, [String? label]) =>
      'The field must match the following: $pattern';

  @override
  String date(String v, [String? label]) => 'The field must be a date type';

  @override
  String negative(String v, [String? label]) =>
      'The field must be a negative number';

  @override
  String positive(String v, [String? label]) =>
      'The field must be a positive number';

  @override
  String dateMax(String v, DateTime min, [String? label]) =>
      'The field must be less than or equal to $min';

  @override
  String dateMin(String v, DateTime min, [String? label]) =>
      'The field must be greater than or equal to $min';

  @override
  String isDouble(String v, [String? label]) =>
      'The field must be a valid double';

  @override
  String isInt(String v, [String? label]) =>
      'The field must be a valid integer';

  @override
  String isTypeOf(v, [String? label]) => 'The field must be of type $v';

  @override
  String listOf(v, [String? label]) => 'The field must be of type $v';

  @override
  String max(String v, num n, [String? label]) =>
      'The field must be less than or equal to $n';

  @override
  String min(String v, num n, [String? label]) =>
      'The field must be greater than or equal to $n';

  @override
  String notOneOf(List items, String v, [String? label]) =>
      'The field must not be one of the following: $items';

  @override
  String oneOf(List items, String v, [String? label]) =>
      'The field must be one of the following: $items';

  @override
  String get unknownFieldMessage => 'The field is unknown';
}
