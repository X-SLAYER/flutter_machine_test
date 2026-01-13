import 'package:dio/dio.dart';

class RequestError extends Error {
  String? code;
  String? message;
  dynamic result;

  RequestError({this.code, this.message, this.result});

  String get errorMessage => '$code: $message';

  RequestError.parseFailed(
    this.result,
  )   : code = '0',
        message = 'Parse failed';

  RequestError.timeout()
      : code = '0',
        message = 'Request timeout';

  RequestError.other()
      : code = '0',
        message = 'Something went wrong';

  RequestError.fromDioException(DioException e) {
    result = e.response?.data is String
        ? e.response?.data.toString()
        : e.response?.data;
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        code = '255';
        message = 'Connection timeout';
      case DioExceptionType.sendTimeout:
        code = '408';
        message = 'Send timeout';
      case DioExceptionType.receiveTimeout:
        code = '408';
        message = 'Receive timeout';
      case DioExceptionType.badCertificate:
        code = '495';
        message = 'SSL Certificate Error';
      case DioExceptionType.cancel:
        code = '444';
        message = 'Request cancelled';
      case DioExceptionType.connectionError:
        code = '1001';
        message = 'Something went wrong';
      case DioExceptionType.badResponse:
        code = '400';
        message = 'Bad response';
      case DioExceptionType.unknown:
        code = '503';
        message = 'Unknown error';
    }
  }

  RequestError.fromJson(Map<String, dynamic> json) {
    code = json['code'] ?? 0;
    message = json['message'] ?? '';
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['result'] = result;
    return data;
  }

  @override
  String toString() {
    return 'RequestError{code=$code, message=$message, result=$result}';
  }
}
