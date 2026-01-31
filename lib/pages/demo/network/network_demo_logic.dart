import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../../common/network/http_service.dart';
import '../../../common/network/config/http_config.dart';

/// 网络层演示控制器
class NetworkDemoLogic extends GetxController {
  late HttpService _httpService;
  CancelToken? _cancelToken;

  final isLoading = false.obs;
  final responseText = ''.obs;
  final requestLogs = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initHttpService();
  }

  void _initHttpService() {
    final config = HttpConfigBuilder()
        .baseUrl('https://jsonplaceholder.typicode.com')
        .connectTimeout(10000)
        .receiveTimeout(10000)
        .enableCache(defaultCacheDuration: const Duration(minutes: 1))
        .enableRetry(maxRetries: 3)
        .enableLog()
        .apiErrorConfig(const ApiErrorConfig(enabled: false))
        .build();
    _httpService = HttpService(config);
  }

  void _log(String message) {
    final time = DateTime.now().toString().substring(11, 19);
    requestLogs.insert(0, '[$time] $message');
    if (requestLogs.length > 20) requestLogs.removeLast();
  }

  void clearLogs() => requestLogs.clear();

  /// GET 请求演示
  Future<void> demoGet() async {
    isLoading.value = true;
    _log('发起 GET 请求: /posts/1');
    try {
      final response = await _httpService.get<Map<String, dynamic>>('/posts/1');
      responseText.value = _formatJson(response);
      _log('GET 请求成功');
    } catch (e) {
      responseText.value = '请求失败: $e';
      _log('GET 请求失败: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// POST 请求演示
  Future<void> demoPost() async {
    isLoading.value = true;
    _log('发起 POST 请求: /posts');
    try {
      final response = await _httpService.post<Map<String, dynamic>>(
        '/posts',
        data: {'title': 'Demo Title', 'body': 'Demo Content', 'userId': 1},
      );
      responseText.value = _formatJson(response);
      _log('POST 请求成功');
    } catch (e) {
      responseText.value = '请求失败: $e';
      _log('POST 请求失败: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// PUT 请求演示
  Future<void> demoPut() async {
    isLoading.value = true;
    _log('发起 PUT 请求: /posts/1');
    try {
      final response = await _httpService.put<Map<String, dynamic>>(
        '/posts/1',
        data: {
          'id': 1,
          'title': 'Updated Title',
          'body': 'Updated',
          'userId': 1
        },
      );
      responseText.value = _formatJson(response);
      _log('PUT 请求成功');
    } catch (e) {
      responseText.value = '请求失败: $e';
      _log('PUT 请求失败: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// DELETE 请求演示
  Future<void> demoDelete() async {
    isLoading.value = true;
    _log('发起 DELETE 请求: /posts/1');
    try {
      await _httpService.delete('/posts/1');
      responseText.value = '删除成功 (返回空响应)';
      _log('DELETE 请求成功');
    } catch (e) {
      responseText.value = '请求失败: $e';
      _log('DELETE 请求失败: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// 缓存演示 - 连续请求同一接口查看缓存效果
  Future<void> demoCache() async {
    isLoading.value = true;
    _log('第1次请求 (无缓存)');
    final start1 = DateTime.now();
    try {
      await _httpService.get('/posts/2');
      final time1 = DateTime.now().difference(start1).inMilliseconds;
      _log('第1次请求耗时: ${time1}ms');

      _log('第2次请求 (有缓存)');
      final start2 = DateTime.now();
      await _httpService.get('/posts/2');
      final time2 = DateTime.now().difference(start2).inMilliseconds;
      _log('第2次请求耗时: ${time2}ms');

      responseText.value = '第1次: ${time1}ms\n第2次: ${time2}ms\n\n缓存命中时请求几乎无延迟';
    } catch (e) {
      responseText.value = '请求失败: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// 请求取消演示
  Future<void> demoCancelRequest() async {
    isLoading.value = true;
    _cancelToken = CancelToken();
    _log('发起请求并在 100ms 后取消');

    Future.delayed(const Duration(milliseconds: 100), () {
      _cancelToken?.cancel('用户手动取消');
      _log('请求已取消');
    });

    try {
      await _httpService.get('/posts', cancelToken: _cancelToken);
      responseText.value = '请求完成';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        responseText.value = '请求被取消: ${e.message}';
        _log('捕获取消异常');
      } else {
        responseText.value = '请求失败: $e';
      }
    } finally {
      isLoading.value = false;
      _cancelToken = null;
    }
  }

  String _formatJson(Map<String, dynamic> json) {
    return json.entries.map((e) => '${e.key}: ${e.value}').join('\n');
  }

  @override
  void onClose() {
    _httpService.dispose();
    super.onClose();
  }
}
