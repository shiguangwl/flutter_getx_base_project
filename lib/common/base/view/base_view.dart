import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import '../controller/base_controller.dart';
import '../state/page_status_widget.dart';
import '../state/page_constant.dart';
import '../state/widget/empty_status_widget.dart';
import '../state/widget/error_status_widget.dart';
import '../state/widget/loading_widget.dart';
import 'abstract_base.dart';

/// 基础视图抽象类
/// 提供通用的视图功能和状态管理，支持页面状态切换和下拉刷新
abstract class BaseView<T extends BaseController> extends AbstractBaseView<T> {
  const BaseView({super.key});

  @override
  Widget buildContentWrapper(Widget contentView) {
    Widget wrappedContent = PageStatusWidget(
      controller: logic.pageStatusController,
      childBuilder: () => contentView,
      customEmptyBuilder: customEmptyBuilder,
      customLoadingBuilder: customLoadingBuilder,
      customErrorBuilder: customErrorBuilder,
    );

    // 如果启用下拉刷新，添加刷新功能
    if (viewConfig.enableDownRefresh) {
      wrappedContent = EasyRefresh(
        header: ClassicHeader(
          dragText: '下拉刷新',
          armedText: '释放刷新',
          readyText: '刷新中...',
          processingText: '刷新中...',
          processedText: '刷新成功',
          noMoreText: '没有更多了',
          failedText: '刷新失败',
          messageText: '上一次刷新时间 %T',
        ),
        controller: EasyRefreshController(),
        onRefresh: () async {
          logic.pageStatusController.startLoadPage();
        },
        child: wrappedContent,
      );
    }

    return wrappedContent;
  }

  // 自定义空状态组件
  Widget customEmptyBuilder(VoidCallback? onRetry) {
    return const EmptyStatusWidget();
  }

  // 自定义错误状态组件
  Widget customErrorBuilder(VoidCallback? onRetry, PageError? error) {
    return ErrorStatusWidget(
      onRetry: onRetry,
      errorMessage: error?.message,
    );
  }

  // 自定义加载状态组件
  Widget customLoadingBuilder(VoidCallback? onRetry) {
    return const LoadingWidget();
  }
}
