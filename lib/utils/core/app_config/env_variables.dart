import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class EnvVariables extends Equatable {
  final String oneSignalID;

  const EnvVariables({
    required this.oneSignalID,
  });

  const EnvVariables.empty() : oneSignalID = '';

  factory EnvVariables.fromJson(Map<dynamic, dynamic> json) {
    return EnvVariables(
      oneSignalID: json['oneSignalID'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'oneSignalID': oneSignalID,
    };
  }

  @override
  List<Object?> get props => [oneSignalID];
}
