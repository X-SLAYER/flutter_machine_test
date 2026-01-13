import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../main.dart';
import '../../../utils/core/app_config/app_config.dart';
import 'common/request_error.dart';
import 'common/xnetwork_model.dart';
import 'dio_service.dart';

typedef HttpResponse<T> = Future<Either<RequestError, T>>;

enum RequestMethod { get, post, put, delete }

enum RequestType { json, formData }

Future<Either<RequestError, R>> sendRequest<T extends XNetworkModel<T>, R>(
  String endPoint, {
  Map<String, dynamic>? body,
  String? customUrl,
  RequestMethod method = RequestMethod.get,
  RequestType type = RequestType.json,
  Map<String, dynamic>? params,
  bool withAuth = false,
  required T responseModel,
}) async {
  try {
    final url = customUrl != null
        ? '$customUrl$endPoint'
        : '${env.baseUrl}$endPoint';

    final requestData = type == RequestType.json
        ? body
        : (body != null ? FormData.fromMap(body) : null);

    final response = await DioService.client.request(
      url,
      data: requestData,
      queryParameters: params,
      options: Options(
        method: method.name.toUpperCase(),
        validateStatus: (_) => true,
      ),
    );

    final statusCode = response.statusCode;
    if (statusCode == null || !isSuccessful(statusCode)) {
      throw RequestError.fromJson(response.data);
    }

    return _parseResponse<T, R>(response.data, responseModel);
  } on DioException catch (e) {
    return left(_handleDioException(e));
  } on TimeoutException catch (_) {
    return left(RequestError.timeout());
  } catch (e) {
    return left(RequestError(code: '-1', message: e.toString()));
  }
}

Future<Either<RequestError, dynamic>> sendPrimitiveRequest(
  String endPoint, {
  Map<String, dynamic>? body,
  String? customUrl,
  RequestMethod method = RequestMethod.get,
  RequestType type = RequestType.json,
  Map<String, dynamic>? params,
  bool withAuth = false,
}) async {
  try {
    final url = customUrl != null
        ? '$customUrl$endPoint'
        : '${env.baseUrl}$endPoint';

    final requestData = type == RequestType.json
        ? body
        : (body != null ? FormData.fromMap(body) : null);

    final response = await DioService.client.request(
      url,
      data: requestData,
      queryParameters: params,
      options: Options(
        method: method.name.toUpperCase(),
        validateStatus: (_) => true,
      ),
    );

    final statusCode = response.statusCode;
    if (statusCode == null || !isSuccessful(statusCode)) {
      throw RequestError.fromJson(response.data);
    }
    if (response.data is String) {
      return right(jsonDecode(response.data)['data']);
    }
    if (response.data is Map<String, dynamic>) {
      return right(response.data['data']);
    }
    throw RequestError.parseFailed(response.data);
  } on DioException catch (e) {
    return left(_handleDioException(e));
  } on TimeoutException catch (_) {
    return left(RequestError.timeout());
  } catch (e) {
    return left(RequestError(code: '-1', message: e.toString()));
  }
}

Either<RequestError, R> _parseResponse<T extends XNetworkModel<T>, R>(
  dynamic data,
  T responseModel,
) {
  try {
    if (data is List) {
      return right(_parseList<T, R>(data, responseModel));
    }

    if (data is String) {
      return right(_parseStringData<T, R>(data, responseModel));
    }

    if (data is Map<String, dynamic>) {
      return right(responseModel.fromJson(data) as R);
    }

    throw RequestError.parseFailed(data);
  } catch (e) {
    $logger.e(e);
    throw RequestError.parseFailed(data);
  }
}

R _parseList<T extends XNetworkModel<T>, R>(
  List<dynamic> data,
  T responseModel,
) {
  final length = data.length;
  final result = List<T>.filled(length, responseModel);

  for (var i = 0; i < length; i++) {
    result[i] = responseModel.fromJson(data[i] as Map<String, dynamic>);
  }

  return result as R;
}

R _parseStringData<T extends XNetworkModel<T>, R>(
  String data,
  T responseModel,
) {
  final decoded = jsonDecode(data);

  if (decoded is! Map<String, dynamic>) {
    throw RequestError.parseFailed(data);
  }

  final dataContent = decoded['data'];

  if (dataContent is List) {
    return _parseList<T, R>(dataContent, responseModel);
  } else if (dataContent is Map<String, dynamic>) {
    return responseModel.fromJson(dataContent) as R;
  } else {
    throw RequestError.parseFailed(data);
  }
}

RequestError _handleDioException(DioException e) {
  try {
    return RequestError.fromDioException(e);
  } catch (_) {
    return RequestError(code: '-1', message: e.toString());
  }
}

@pragma('vm:prefer-inline')
bool isSuccessful(int status) => status >= 200 && status <= 300;
