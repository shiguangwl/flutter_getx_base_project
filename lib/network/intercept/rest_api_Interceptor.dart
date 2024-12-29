import 'package:dio/dio.dart';
class ApiInterceptor extends Interceptor {
  ApiInterceptor();

  Future requestAuth(RequestOptions options) async {
    // LoginUserData loginUserData = await DataBox.loginInfoBox;
    // options.headers['Authorization'] =
    //     'Bearer ${loginUserData.accessToken ?? ""}';
    // options.headers['platform'] = 'APP';
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    requestAuth(options).then((value) {
      return handler.next(options);
    });
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO 用户登录过期处理/踢人下线
    return handler.next(response);
  }
}
