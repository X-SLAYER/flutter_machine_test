import 'package:ez_validator/ez_validator.dart';

final EzSchema envSchema = EzSchema.shape({
  'oneSignalID': EzValidator<String>(optional: true).required(),
});
