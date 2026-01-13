import '../../../../../constant/shared_prefences.dart';
import '../../../../../data/locale/locale_db/locale_db_manager.dart';
import '../../../../../stores/providers/main_provider.dart';
import '../../../external/leave_request_form/data/leave_request_data.dart';
import '../../../external/leave_request_form/utils/enums/request_status.dart';

class MyRequestsViewModel extends MainProvider {
  final List<LeaveRequestData> _requests = [];
  List<LeaveRequestData> get requests => _requests;

  void loadRequests() {
    setLoading(true);
    _requests.clear();
    final requests = XLocalStorage.readList(
      SharedPrefsKeys.leaveRequests,
      LeaveRequestData.fromJson,
    );
    requests.sort((a, b) => b.requestedAt.compareTo(a.requestedAt));
    _requests.addAll(requests);
    setLoading(false);
  }

  void changeRequestStatus(int id, RequestStatus status) {
    final itemId = _requests.indexWhere((element) => element.id == id);
    if (itemId != -1) {
      final request = _requests[itemId];
      final newRequest = request.copyWith(status: status);
      _requests[itemId] = newRequest;
      XLocalStorage.storeJsonList(
        SharedPrefsKeys.leaveRequests,
        _requests.map((e) => e.toJson()).toList(),
      );
      loadRequests();
    }
  }
}
