import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../get/get_ctrl_init.dart';
import 'page_constant.dart';
import 'widget/loading_widget.dart';
import 'page_status_controller.dart';
import 'widget/empty_status_widget.dart';
import 'widget/error_status_widget.dart';

typedef CustomStatusBuilder = Widget Function(VoidCallback? onRetry);
typedef PageErrorWidgetBuilder = Widget Function(
    VoidCallback? onRetry, PageError? error);

class PageStatusWidget extends StatelessWidget {
  final Widget Function() childBuilder;
  final PageStatusController controller;
  final CustomStatusBuilder? customLoadingBuilder;
  final PageErrorWidgetBuilder? customErrorBuilder;
  final CustomStatusBuilder? customEmptyBuilder;

  const PageStatusWidget({
    super.key,
    required this.controller,
    required this.childBuilder,
    this.customLoadingBuilder,
    this.customErrorBuilder,
    this.customEmptyBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return GetCtrlInit(
      controller: controller,
      tag: "PageStatusWidget_${controller.hashCode.toString()}",
      child: Obx(() {
        final state = controller.pageState;
        final error = controller.errorInfo;
        return _buildByState(state.value, error.value);
      }),
    );
  }

  Widget _buildByState(PageState state, PageError? error) => switch (state) {
        PageState.loading => _buildStatusWidget(
            customLoadingBuilder,
            const LoadingWidget(),
          ),
        PageState.empty => _buildStatusWidget(
            customEmptyBuilder,
            const EmptyStatusWidget(),
          ),
        PageState.error => _buildErrorWidget(controller.startLoadPage, error),
        PageState.success => childBuilder(),
      };

  Widget _buildStatusWidget(
    CustomStatusBuilder? customBuilder,
    Widget defaultWidget,
  ) {
    return customBuilder?.call(controller.startLoadPage) ?? defaultWidget;
  }

  Widget _buildErrorWidget(VoidCallback onRetry, PageError? error) {
    return customErrorBuilder?.call(onRetry, error) ??
        ErrorStatusWidget(
          onRetry: onRetry,
          errorMessage: error?.message ?? '加载失败',
        );
  }
}
