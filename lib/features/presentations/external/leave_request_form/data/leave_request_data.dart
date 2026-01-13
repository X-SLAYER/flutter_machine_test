import '../../../../../data/network/dio/handlers/form_requests/models/employee_model.dart';
import '../../../../../data/network/dio/handlers/form_requests/models/leave_request_model.dart';
import '../../../../../entities/drop_down_entity.dart';
import '../../../../../utils/core/extensions/extensions_export.dart';
import '../utils/enums/request_status.dart';

class LeaveRequestData {
  final int id;
  final String days;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime requestedAt;
  final String? notes;
  final LeaveTypesModel leaveRequestData;
  final EmployeeModel delegateDuringLeave;
  final RequestStatus status;

  String get startEndDate =>
      '${startDate.formatDate('dd MMM')} - ${endDate.formatDate('dd MMM')}';

  LeaveRequestData({
    required this.id,
    required this.days,
    required this.startDate,
    required this.endDate,
    required this.leaveRequestData,
    required this.delegateDuringLeave,
    required this.status,
    required this.requestedAt,
    this.notes,
  });

  factory LeaveRequestData.fromForm(Map<dynamic, dynamic> json) {
    return LeaveRequestData(
      id: DateTime.now().millisecondsSinceEpoch,
      days: json['Days'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      notes: json['notes'],
      leaveRequestData: LeaveTypesModel.fromJson(
        (json['absenceType'] as DropDownEntity).toJson(),
      ),
      delegateDuringLeave: EmployeeModel.fromJson(
        (json['DelegateDuringLeave'] as DropDownEntity).toJson(),
      ),
      status: RequestStatus.pending,
      requestedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'days': days,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'requestedAt': requestedAt.toIso8601String(),
      'notes': notes,
      'absenceType': leaveRequestData.toJson(),
      'delegateDuringLeave': delegateDuringLeave.toJson(),
      'status': status.name,
    };
  }

  factory LeaveRequestData.fromJson(Map<String, dynamic> json) {
    return LeaveRequestData(
      id: json['id'],
      days: json['days'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      requestedAt: json['requestedAt'] != null
          ? DateTime.parse(json['requestedAt'])
          : DateTime.now(),
      notes: json['notes'],
      leaveRequestData: LeaveTypesModel.fromJson(json['absenceType']),
      delegateDuringLeave: EmployeeModel.fromJson(json['delegateDuringLeave']),
      status: json['status'] != null
          ? RequestStatus.values.byName(json['status'])
          : RequestStatus.pending,
    );
  }

  LeaveRequestData copyWith({
    int? id,
    String? days,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? requestedAt,
    String? notes,
    LeaveTypesModel? leaveRequestData,
    EmployeeModel? delegateDuringLeave,
    RequestStatus? status,
  }) => LeaveRequestData(
    id: id ?? this.id,
    days: days ?? this.days,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    requestedAt: requestedAt ?? this.requestedAt,
    notes: notes ?? this.notes,
    leaveRequestData: leaveRequestData ?? this.leaveRequestData,
    delegateDuringLeave: delegateDuringLeave ?? this.delegateDuringLeave,
    status: status ?? this.status,
  );
}
