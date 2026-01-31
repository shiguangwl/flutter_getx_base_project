import 'package:flutter/material.dart';
import '../config/view_config.dart';
import '../config/refresh_position.dart';
import '../refresh/page_refreshable_widget.dart';
import '../state/widget/empty_status_widget.dart';
import '../state/widget/error_status_widget.dart';
import '../state/widget/loading_widget.dart';
import '../state/page_status_widget.dart';
import '../state/page_constant.dart';
import 'abstract_base.dart';
import '../controller/refreshable_controller.dart';
import '_pinned_header_wrapper.dart';

abstract class RefreshableView<T extends RefreshableController<P>, P>
    extends AbstractBaseView<T> {
  const RefreshableView({super.key});

  @override
  RefreshableConfig get viewConfig => RefreshableConfig();

  /// 构建列表项
  /// @param items 列表数据
  /// @param item 列表项数据
  /// @param index 列表项索引
  Widget buildListItem(List<P> items, P item, int index);

  /// 构建头部
  Widget? buildHeadView() {
    return null;
  }

  /// 获取头部高度(可选：当pinHeader为true时，必须实现此方法)
  int headViewHeight() {
    return 0;
  }

  @override
  Widget buildContent() {
    final headerWidget = buildHeadView();
    final hasHeader = headerWidget != null;

    // 验证固定头部的配置
    if (viewConfig.pinHeader) {
      if (headViewHeight() <= 0) {
        throw Exception('当pinHeader为true时，必须实现headViewHeight方法，并且返回值必须大于0');
      }
      if (!hasHeader) {
        throw Exception('当pinHeader为true时，必须实现buildHeadView方法，并且返回值不能为null');
      }
    }

    return PageStatusWidget(
      controller: logic.pageCtrl,
      childBuilder: () => hasHeader
          ? _buildContentWithHeader(headerWidget)
          : _buildContentWithoutHeader(),
      customLoadingBuilder: customListLoadingBuilder,
      customErrorBuilder: customListErrorBuilder,
      customEmptyBuilder: customListEmptyBuilder,
    );
  }

  /// 构建无头部的可刷新内容
  Widget _buildContentWithoutHeader() {
    return PageRefreshableWidget<P>(
      refresCtrl: logic.listCtrl,
      itemBuilder: buildListItem,
      customListEmptyBuilder: customListEmptyBuilder,
      customListErrorBuilder: customListErrorBuilder,
      customListLoadingBuilder: customListLoadingBuilder,
    );
  }

  /// 构建带头部的可刷新内容
  Widget _buildContentWithHeader(Widget headerWidget) {
    final isBelowHeader =
        viewConfig.refreshPosition == RefreshPosition.belowHeader;

    if (isBelowHeader) {
      return _buildRefreshBelowHeader(headerWidget);
    } else {
      return _buildRefreshAboveHeader(headerWidget);
    }
  }

  /// 构建刷新位置在header下方的布局
  Widget _buildRefreshBelowHeader(Widget headerWidget) {
    if (viewConfig.pinHeader) {
      // 固定头部
      return Column(
        children: [
          headerWidget,
          Expanded(
            child: PageRefreshableWidget<P>(
              refresCtrl: logic.listCtrl,
              itemBuilder: buildListItem,
              enableRefresh: viewConfig.enableDownRefresh,
              enableLoadMore: viewConfig.enableUpRefresh,
              customListEmptyBuilder: customListEmptyBuilder,
              customListErrorBuilder: customListErrorBuilder,
              customListLoadingBuilder: customListLoadingBuilder,
            ),
          ),
        ],
      );
    } else {
      // 非固定头部
      return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(child: headerWidget),
        ],
        body: PageRefreshableWidget<P>(
          refresCtrl: logic.listCtrl,
          itemBuilder: buildListItem,
          enableRefresh: viewConfig.enableDownRefresh,
          enableLoadMore: viewConfig.enableUpRefresh,
          customListEmptyBuilder: customListEmptyBuilder,
          customListErrorBuilder: customListErrorBuilder,
          customListLoadingBuilder: customListLoadingBuilder,
        ),
      );
    }
  }

  /// 构建刷新位置在header上方的布局
  Widget _buildRefreshAboveHeader(Widget headerWidget) {
    final refreshWidget = PageRefreshableWidget<P>(
      refresCtrl: logic.listCtrl,
      itemBuilder: buildListItem,
      enableRefresh: viewConfig.enableDownRefresh,
      enableLoadMore: viewConfig.enableUpRefresh,
      customListEmptyBuilder: customListEmptyBuilder,
      customListErrorBuilder: customListErrorBuilder,
      customListLoadingBuilder: customListLoadingBuilder,
      customSliverBuilder: () => _buildSlivers(headerWidget),
    );

    // 固定头部场景：使用优化后的 PinnedHeaderWrapper
    if (viewConfig.pinHeader) {
      return PinnedHeaderWrapper(
        pinnedHeader: headerWidget,
        pinnedHeaderHeight: headViewHeight().toDouble(),
        child: refreshWidget,
      );
    } else {
      return refreshWidget;
    }
  }

  /// 构建Sliver列表（供EasyRefresh.builder使用）
  List<Widget> _buildSlivers(Widget headerWidget) {
    return [
      // 对于固定头部场景，始终使用普通的 SliverToBoxAdapter
      // 让头部参与下拉刷新，固定效果通过 PinnedHeaderWrapper 实现
      SliverToBoxAdapter(child: headerWidget),
      // 列表内容
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final items = logic.listCtrl.items;
          if (index >= 0 && index < items.length) {
            return buildListItem(items, items[index], index);
          }
          return const SizedBox.shrink();
        }, childCount: logic.listCtrl.items.length),
      ),
    ];
  }

  /// 页面的的自定义状态
  Widget customPageEmptyBuilder(VoidCallback? onRetry) {
    return const EmptyStatusWidget();
  }

  Widget customPageErrorBuilder(VoidCallback? onRetry, PageError? error) {
    return ErrorStatusWidget(onRetry: onRetry, errorMessage: error?.message);
  }

  Widget customPageLoadingBuilder(VoidCallback? onRetry) {
    return const LoadingWidget();
  }

  /// 列表的自定义状态
  Widget customListEmptyBuilder(VoidCallback? onRetry) {
    return const EmptyStatusWidget();
  }

  Widget customListErrorBuilder(VoidCallback? onRetry, PageError? error) {
    return ErrorStatusWidget(onRetry: onRetry, errorMessage: error?.message);
  }

  Widget customListLoadingBuilder(VoidCallback? onRetry) {
    return const LoadingWidget();
  }
}
