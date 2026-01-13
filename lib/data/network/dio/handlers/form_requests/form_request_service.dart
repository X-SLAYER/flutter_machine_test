import '../../../../../constant/api_paths.dart';
import '../../dio_resolver.dart';
import 'models/employee_model.dart';
import 'models/form_data_model.dart';
import 'models/leave_request_model.dart';

class FormRequestService {
  FormRequestService._();

  static HttpResponse<List<LeaveTypesModel>> getLeaveTypes() async {
    return sendRequest<LeaveTypesModel, List<LeaveTypesModel>>(
      leaveTypesUri,
      responseModel: LeaveTypesModel(),
    );
  }

  static HttpResponse<List<EmployeeModel>> getEmployees() async {
    return sendRequest<EmployeeModel, List<EmployeeModel>>(
      employeesUri,
      responseModel: EmployeeModel(),
    );
  }

  static HttpResponse<FormDataModel> getFormData() async {
    return sendRequest<FormDataModel, FormDataModel>(
      formDataUri,
      responseModel: FormDataModel(),
    );
  }

  static HttpResponse<dynamic> sendPrimitiveCall(String urlPath) async {
    return sendPrimitiveRequest(urlPath);
  }
}
