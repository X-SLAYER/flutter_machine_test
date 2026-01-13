import '../../../../constant/shared_prefences.dart';
import '../../../../data/locale/locale_db/locale_db_manager.dart';
import '../../../../data/network/dio/handlers/form_requests/form_request_service.dart';
import '../../../../data/network/dio/handlers/form_requests/models/employee_model.dart';
import '../../../../data/network/dio/handlers/form_requests/models/form_data_model.dart';
import '../../../../data/network/dio/handlers/form_requests/models/leave_request_model.dart';
import '../../../../entities/drop_down_entity.dart';
import '../../../../main.dart' show $logger;
import '../../../../stores/providers/main_provider.dart';
import '../../../../widgets/forms/ez_form.dart';
import 'data/leave_request_data.dart';
import 'utils/form_engine.dart';

class LeaveFormViewModel extends MainProvider {
  final FormEngine formEngine = FormEngine();
  final EzFormController controller = EzFormController();

  final List<DropDownEntity> leaveTypesEntities = [];
  final List<DropDownEntity> employeesEntities = [];

  final List<FormSection> _formSections = [];
  List<FormSection> get formSections => _formSections;

  Map<String, List<DropDownEntity>> get dropDownValuesMap {
    return {
      'absenceType': leaveTypesEntities,
      'DelegateDuringLeave': employeesEntities,
    };
  }

  Future<void> loadDropDownEntities() async {
    final leaveTypes = XLocalStorage.readList(
      SharedPrefsKeys.leaveTypes,
      LeaveTypesModel.fromJson,
    );
    final employees = XLocalStorage.readList(
      SharedPrefsKeys.employees,
      EmployeeModel.fromJson,
    );
    leaveTypesEntities.addAll(leaveTypes.map((e) => e.toEntity()));
    employeesEntities.addAll(employees.map((e) => e.toEntity()));
    setLoading(false);
  }

  Future<void> getFormData() async {
    setLoading(true);
    final result = await FormRequestService.getFormData();
    result.fold(
      (error) {
        $logger.e(error);
        setLoading(false);
      },
      (success) {
        _formSections.addAll(success.formSections ?? []);
        loadDropDownEntities();
      },
    );
  }

  void storeDataLocally() {
    final leaveRequestData = LeaveRequestData.fromForm(
      controller.data,
    );
    XLocalStorage.storeJsonToList(
      SharedPrefsKeys.leaveRequests,
      leaveRequestData.toJson(),
    );
  }

  // final mockData = [
  //   {
  //     'id': 164,
  //     'labelEn': 'Leave Type ',
  //     'labelAr': 'نوع الإجازة',
  //     'type': 4,
  //     'fieldMapping': 'absenceType',
  //     'apiUrl': 'Leave/GetLeaveType',
  //     'isRequired': true,
  //     'isReadOnly': false,
  //     'inputFieldValidations': [
  //       ]
  //     },
  //   {
  //     'id': 497,
  //     'labelEn': 'Start Date',
  //     'labelAr': 'اعتبارا من',
  //     'type': 11,
  //     'fieldMapping': 'startDate',
  //     'apiUrl': '',
  //     'isRequired': true,
  //     'isReadOnly': false,
  //     'inputFieldValidations': [
  //       ]
  //     },
  //   {
  //     'id': 498,
  //     'labelEn': 'End Date',
  //     'labelAr': 'حتى',
  //     'type': 11,
  //     'fieldMapping': 'endDate',
  //     'apiUrl': '',
  //     'isRequired': true,
  //     'isReadOnly': false,
  //     'inputFieldValidations': [
  //       ]
  //     },
  //   {
  //     'id': 499,
  //     'labelEn': 'Days',
  //     'labelAr': 'الأيام',
  //     'type': 1,
  //     'fieldMapping': 'Days',
  //     'apiUrl': '',
  //     'isRequired': false,
  //     'isReadOnly': true,
  //     'isActive': true,
  //     'inputFieldValidations': [
  //       {
  //         'id': 137,
  //         'validationType': 'CalculateDaysBetweenDates',
  //         'validationValue': 'startDate,endDate',
  //         'inputFieldId': 499,
  //       },
  //     ],
  //   },
  //   {
  //     'id': 500,
  //     'labelEn': 'Comments',
  //     'labelAr': 'الملاحظات',
  //     'type': 1,
  //     'fieldMapping': 'notes',
  //     'apiUrl': '',
  //     'isRequired': false,
  //     'isReadOnly': false,
  //     'inputFieldValidations': [
  //       ]
  //     },
  //   {
  //     'id': 548,
  //     'labelEn': 'Delegate To',
  //     'labelAr': 'مندوب إلى',
  //     'type': 4,
  //     'fieldMapping': 'DelegateDuringLeave',
  //     'apiUrl': 'Leave/GetLeaveDelegations',
  //     'isRequired': true,
  //     'isReadOnly': false,
  //     'inputFieldValidations': [
  //       ]
  //     },
  // ].map((e) => FormSection.fromJson(e)).toList();
}
