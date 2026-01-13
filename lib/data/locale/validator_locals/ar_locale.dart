import 'package:ez_validator/ez_validator.dart';

class ArLocale implements EzLocale {
  const ArLocale();

  @override
  String get name => 'arabic';

  @override
  String minLength(String v, int n, [String? label]) =>
      'يجب أن تتكون الخانة من $n من الأحرف على الأقل';

  @override
  String maxLength(String v, int n, [String? label]) =>
      'يجب أن تتألف الخانة من $n من الأحرف على الأكثر';

  @override
  String email(String v, [String? label]) =>
      'الخانة ليس عنوان بريد إلكتروني صالحًا';

  @override
  String phoneNumber(String v, [String? label]) => 'الخانة ليس رقم هاتف صالحًا';

  @override
  String required([String? label]) => 'خانة مطلوبة';

  @override
  String ip(String v, [String? label]) => 'الخانة ليست عنوان IP صالحًا';

  @override
  String ipv6(String v, [String? label]) => 'الخانة ليست عنوان IPv6 صالحًا';

  @override
  String url(String v, [String? label]) => 'الخانة ليست عنوان url صالحًا';

  @override
  String boolean(String v, [String? label]) => 'الخانة ليست نوعًا منطقيًا';

  @override
  String uuid(String v, [String? label]) => 'الخانة ليست معرفًا صالحًا';

  @override
  String lowerCase(String v, [String? label]) => 'الخانة ليست بالأحرف الصغيرة';

  @override
  String upperCase(String v, [String? label]) => 'الخانة ليست بالأحرف الكبيرة';

  @override
  String notNumber(String v, [String? label]) => 'يجب ألا تتكون الخانة رقمًا';

  @override
  String number(String v, [String? label]) => 'الخانة ليست رقمًا صالحًا';

  @override
  String matches(String pattern, String v, [String? label]) =>
      'يجب أن تتطابق الخانة مع ما يلي: $pattern';

  @override
  String date(String v, [String? label]) => 'يجب أن تكون الخانة نوع تاريخ';

  @override
  String negative(String v, [String? label]) =>
      'يجب أن تكون الخانة رقمًا سالبًا';

  @override
  String positive(String v, [String? label]) =>
      'يجب أن تكون الخانة رقمًا موجبًا';

  @override
  String dateMax(String v, DateTime min, [String? label]) =>
      'يجب أن تكون الخانة أقل من أو تساوي $min';

  @override
  String dateMin(String v, DateTime min, [String? label]) =>
      'يجب أن تكون الخانة أكبر من أو تساوي $min';

  @override
  String isDouble(String v, [String? label]) =>
      'يجب أن تكون الخانة رقمًا عشريًا';

  @override
  String isInt(String v, [String? label]) => 'يجب أن تكون الخانة رقمًا صحيحًا';

  @override
  String isTypeOf(v, [String? label]) => 'يجب أن تكون الخانة من نوع $v';

  @override
  String listOf(v, [String? label]) => 'يجب أن تكون الخانة من نوع $v';

  @override
  String max(String v, num n, [String? label]) =>
      'يجب أن تكون الخانة أقل من أو تساوي $n';

  @override
  String min(String v, num n, [String? label]) =>
      'يجب أن تكون الخانة أكبر من أو تساوي $n';

  @override
  String notOneOf(List items, String v, [String? label]) =>
      "يجب ألا تكون الخانة واحدة من ${items.join(', ')}";

  @override
  String oneOf(List items, String v, [String? label]) =>
      "يجب أن تكون الخانة واحدة من ${items.join(', ')}";

  @override
  String get unknownFieldMessage => 'الخانة غير معروفة';
}
