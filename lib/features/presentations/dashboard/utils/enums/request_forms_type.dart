import '../../../../../constant/assets.dart';

enum RequestFormsType {
  leave,
  loan,
  certificate,
  invoice;

  bool get isComingSoon => [loan, certificate, invoice].contains(this);

  String get icon => switch (this) {
    leave => Assets.leave,
    loan => Assets.corp,
    certificate => Assets.certificate,
    invoice => Assets.invoice,
  };
}
