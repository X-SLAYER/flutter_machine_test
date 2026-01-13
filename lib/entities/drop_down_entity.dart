import 'package:equatable/equatable.dart';

class DropDownEntity extends Equatable {
  final num id;
  final dynamic lookupCode;
  final String name;
  final String arabicName;

  const DropDownEntity({
    required this.id,
    required this.lookupCode,
    required this.name,
    required this.arabicName,
  });

  String nameByLocale(bool isAr) => isAr ? arabicName : name;

  @override
  List<Object?> get props => [
    id,
    lookupCode,
    name,
    arabicName,
  ];

  factory DropDownEntity.fromJson(Map<String, dynamic> json) => DropDownEntity(
    id: json['id'],
    lookupCode: json['lookupCode'],
    name: json['name'],
    arabicName: json['arabicName'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'lookupCode': lookupCode,
    'name': name,
    'arabicName': arabicName,
  };
}
