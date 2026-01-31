import 'package:dio/dio.dart';

import '../config/http_config.dart';
import '../exception/api_exception.dart';

class ApiErrorInterceptor extends Interceptor {
  final ApiErrorConfig? apiErrorConfig;

  ApiErrorInterceptor(this.apiErrorConfig);

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (apiErrorConfig?.enabled != true) {
      handler.next(response);
      return;
    }

    final data = response.data;

    if (data is Map) {
      final dynamic codeValue = data['code'];

      int? code;
      if (codeValue is num) {
        code = codeValue.toInt();
      } else if (codeValue is String) {
        final parsed = int.tryParse(codeValue);
        if (parsed != null) code = parsed;
      }

      if (code != 200) {
        final String? message = data['msg'] as String?;
        handler.reject(
          ApiException(
            code: code ?? -1,
            message: message,
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
          ),
          true,
        );
        return;
      }
    }

    handler.next(response);
  }
}
