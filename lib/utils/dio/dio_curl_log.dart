import 'dart:convert';

import 'package:dio/dio.dart';
import '../../main.dart';

class CurlLoggerDioInterceptor extends Interceptor {
  final bool convertFormData;

  CurlLoggerDioInterceptor({this.convertFormData = true});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      $logger.f(_cURLRepresentation(options));
    } catch (err) {
      $logger.e('unable to create a CURL representation of the requestOptions');
    }
    super.onRequest(options, handler);
  }

  String _cURLRepresentation(RequestOptions options) {
    final List<String> components = ['curl -i'];
    if (options.method.toUpperCase() != 'GET') {
      components.add('-X ${options.method}');
    }

    options.headers.forEach((k, v) {
      if (k.toLowerCase() != 'cookie') {
        components.add('-H "$k: $v"');
      }
    });

    if (options.data != null) {
      final data = json.encode(options.data).replaceAll('"', r'\"');
      components.add('-d "$data"');
    }

    components.add('"${options.uri}"');

    return components.join(' \\\n\t');
  }
}
