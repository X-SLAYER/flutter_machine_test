import '../../../../../constant/api_paths.dart';
import '../../../../../data/network/dio/handlers/form_requests/models/employee_model.dart';
import '../../../../../data/network/dio/handlers/form_requests/models/leave_request_model.dart';

class DynamicDataMaps {
  static Map<String, dynamic> types = {
    'Leave/GetLeaveType': LeaveTypesModel,
    'Leave/GetLeaveDelegations': EmployeeModel,
  };

  static Map<String, String> apis = {
    'Leave/GetLeaveType': leaveTypesUri,
    'Leave/GetLeaveDelegations': employeesUri,
    // we add more if we need to
  };
}
