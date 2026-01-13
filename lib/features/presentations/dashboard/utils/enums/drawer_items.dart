import '../../../../../constant/assets.dart';

enum DrawerItems {
  userDashboard,
  myRequests,
  settings;

  String get icon => switch (this) {
    userDashboard => Assets.home,
    myRequests => Assets.listCheck,
    settings => Assets.settings,
  };
}
