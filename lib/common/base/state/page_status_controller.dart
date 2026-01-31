import 'dart:async';
import 'package:get/get.dart';

import '../../log/logger.dart';
import 'page_constant.dart';

typedef PageLoading = Future<PageResult> Function();

class PageStatusController extends GetxController {
  final PageLoading onLoadPage;
  final Rx<PageState> pageState = PageState.loading.obs;
  final Rx<PageError?> errorInfo = Rx<PageError?>(null);

  PageStatusController(this.onLoadPage);

  @override
  void onReady() {
    super.onReady();
    startLoadPage();
  }

  void startLoadPage() async {
    setState(PageState.loading);
    try {
      final result = await onLoadPage();
      if (result is PageSuccess) {
        setSuccess();
      } else if (result is PageEmpty) {
        setEmpty();
      } else if (result is PageFailure) {
        setError(result.error);
      }
    } catch (e, s) {
      Log.e("页面状态加载异常", e, s);
      setError(PageError.unknownError);
    }
  }

  void setState(PageState state, [PageError? error]) {
    pageState.value = state;
    errorInfo.value = error;
  }

  void setSuccess() => setState(PageState.success);
  void setEmpty([String? message]) => setState(PageState.empty);
  void setError(PageError error) => setState(PageState.error, error);
}
