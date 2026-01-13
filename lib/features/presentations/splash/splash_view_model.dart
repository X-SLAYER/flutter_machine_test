import '../../../constant/shared_prefences.dart';
import '../../../data/locale/locale_db/locale_db_manager.dart';
import '../../../data/network/dio/handlers/form_requests/form_request_service.dart';
import '../../../main.dart' show $logger;
import '../../../stores/providers/main_provider.dart';
import '../../../utils/animations/route_transation.dart';
import '../../../utils/app_utils/system_manager.dart';
import '../dashboard/home.dart';

class SplashViewModel extends MainProvider {
  void init() {
    Future.wait([
      getLeaveTypes(),
      getEmployees(),
    ]).whenComplete(() {
      pushReplaceScreenWithTransitions(
        const HomePage(),
        AnimationType.fade,
      );
    });
  }

  Future<void> getLeaveTypes() async {
    final result = await FormRequestService.getLeaveTypes();
    result.fold(
      (error) {
        $logger.e(error);
      },
      (success) {
        XLocalStorage.saveList(
          SharedPrefsKeys.leaveTypes,
          success,
        );
      },
    );
  }

  Future<void> getEmployees() async {
    final result = await FormRequestService.getEmployees();
    result.fold(
      (error) {
        $logger.e(error);
      },
      (success) {
        XLocalStorage.saveList(
          SharedPrefsKeys.employees,
          success,
        );
      },
    );
  }
}
