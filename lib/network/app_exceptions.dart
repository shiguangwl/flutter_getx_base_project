import 'dart:io';

import 'package:dio/dio.dart';


/// 自定义异常
class AppException implements Exception {
  static const String CLIENT_NET_ERROR = "网络异常，请检网络连接状态";
  static const String SERVER_NET_ERROR = "系统繁忙，请稍后再试!";
  static const String NET_CONNECT_ERROR = "网络未连接，请检查后重试";
  static const String TOO_MANY_REQUEST = "顾客太多，请稍等";

  late final String message;
  late final int code;

  AppException(this.code, this.message);

  String toString() {
    return "$code$message";
  }

  factory AppException.create(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return BadRequestException(-1, "请求取消");
      case DioExceptionType.connectionTimeout: //连接超时
      case DioExceptionType.sendTimeout: //请求超时
        return BadRequestException(-1, CLIENT_NET_ERROR);
      case DioExceptionType.receiveTimeout: //响应超时
        return BadRequestException(-1, SERVER_NET_ERROR);
      case DioExceptionType.badResponse:
        try {
          int errCode = error.response!.statusCode!;
          // String errMsg = error.response.statusMessage;
          // return ErrorEntity(code: errCode, message: errMsg);
          switch (errCode) {
            case 400:
              print('请求语法错误');
              return BadRequestException(errCode, SERVER_NET_ERROR);
            case 401: //没有权限
            case 403: //服务器拒绝执行
            case 404: //无法连接服务器
            case 405: //请求方法被禁止
            case 500: //服务器内部错误
            case 502: //无效的请求
            case 503: //服务器挂了
            case 505: //不支持HTTP协议请求
              return UnauthorisedException(errCode, SERVER_NET_ERROR);
            case 429:
              return AppException(errCode, TOO_MANY_REQUEST);
            default:
              // return ErrorEntity(code: errCode, message: "未知错误");
              return AppException(errCode, error.response!.statusMessage!);
          }
        } on Exception catch (_) {
          print('不通1');
          return AppException(-1, NET_CONNECT_ERROR);
        }
      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return AppException(-1, CLIENT_NET_ERROR);
        } else {
          print('不通2 ${error}');
          return AppException(-1, NET_CONNECT_ERROR);
        }
      default:
        print('不通3');
        // LoadingUtil.showToast("网络异常: ${error.message}", seconds: 5);
        return AppException(-1, NET_CONNECT_ERROR);
    }
  }
}

/// 请求错误
class BadRequestException extends AppException {
  BadRequestException([code, message]) : super(code, message);
}

/// 未认证异常
class UnauthorisedException extends AppException {
  UnauthorisedException([code, message]) : super(code, message);
}
