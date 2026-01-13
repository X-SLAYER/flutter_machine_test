import '../../../../../../entities/drop_down_entity.dart';
import '../../../common/xnetwork_model.dart';

class EmployeeModel extends XNetworkModel<EmployeeModel>
    implements DataMapper<DropDownEntity> {
  final num? id;
  final dynamic lookupCode;
  final String? name;
  final String? arabicName;

  EmployeeModel({
    this.id,
    this.lookupCode,
    this.name,
    this.arabicName,
  });

  String nameByLocale(bool isAr) {
    return isAr ? arabicName ?? '' : name ?? '';
  }

  EmployeeModel copyWith({
    num? id,
    dynamic lookupCode,
    String? name,
    String? arabicName,
  }) => EmployeeModel(
    id: id ?? this.id,
    lookupCode: lookupCode ?? this.lookupCode,
    name: name ?? this.name,
    arabicName: arabicName ?? this.arabicName,
  );

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
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
  EmployeeModel fromJson(Map<String, dynamic> json) =>
      EmployeeModel.fromJson(json);

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
