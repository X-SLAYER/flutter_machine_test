import '../../../../../../entities/drop_down_entity.dart';
import '../../../common/xnetwork_model.dart';

class LeaveTypesModel extends XNetworkModel<LeaveTypesModel>
    implements DataMapper<DropDownEntity> {
  final num? id;
  final dynamic lookupCode;
  final String? name;
  final String? arabicName;

  LeaveTypesModel({
    this.id,
    this.lookupCode,
    this.name,
    this.arabicName,
  });

  String nameByLocale(bool isAr) => isAr ? arabicName ?? '' : name ?? '';

  LeaveTypesModel copyWith({
    num? id,
    dynamic lookupCode,
    String? name,
    String? arabicName,
  }) => LeaveTypesModel(
    id: id ?? this.id,
    lookupCode: lookupCode ?? this.lookupCode,
    name: name ?? this.name,
    arabicName: arabicName ?? this.arabicName,
  );

  factory LeaveTypesModel.fromJson(Map<String, dynamic> json) =>
      LeaveTypesModel(
        id: json['id'],
        lookupCode: json['lookupCode'],
        name: json['name'],
        arabicName: json['arabicName'],
      );

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'lookupCode': lookupCode,
    'name': name,
    'arabicName': arabicName,
  };

  @override
  LeaveTypesModel fromJson(Map<String, dynamic> json) =>
      LeaveTypesModel.fromJson(json);

  @override
  DropDownEntity toEntity() {
    return DropDownEntity(
      id: id ?? 0,
      lookupCode: lookupCode,
      name: name ?? '',
      arabicName: arabicName ?? '',
    );
  }
}
