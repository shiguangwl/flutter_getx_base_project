// 我是MCP智能编程助手（mcp-feedback-enhanced）。
import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';

import '../get/get_ctrl_init.dart';
import 'page_refreshable_controller.dart';
import '../state/page_status_widget.dart';

typedef ItemBuilder<T> = Widget Function(List<T> items, T item, int index);
typedef SeparatorBuilder<T> = Widget Function(List<T> items, int index);

/// 纯粹的可刷新列表组件（专注列表功能）
class PageRefreshableWidget<T> extends StatelessWidget {
  /// 控制器
  final PageRefreshableController<T> refresCtrl;

  /// 列表项构建器
  final ItemBuilder<T> itemBuilder;

  /// 列表项分割器
  final SeparatorBuilder<T>? separatorBuilder;

  /// 列表内边距
  final EdgeInsetsGeometry? padding;

  /// 列表滚动控制器
  final ScrollController? scrollController;

  /// 列表滚动物理属性
  final ScrollPhysics? physics;

  /// 列表头部
  final Header? header;

  /// 列表尾部
  final Footer? footer;

  /// 是否启用下拉刷新
  final bool enableRefresh;

  /// 是否启用上拉加载
  final bool enableLoadMore;

  /// 列表加载状态构建器
  final CustomStatusBuilder? customListLoadingBuilder;

  /// 列表错误状态构建器
  final PageErrorWidgetBuilder? customListErrorBuilder;

  /// 列表空状态构建器
  final CustomStatusBuilder? customListEmptyBuilder;

  /// 自定义滚动视图构建器（可选，用于支持CustomScrollView等复杂布局）
  final Widget Function()? customScrollViewBuilder;

  /// 自定义Sliver构建器（用于直接在EasyRefresh中构建Sliver）
  final List<Widget> Function()? customSliverBuilder;

  const PageRefreshableWidget({
    super.key,
    required this.refresCtrl,
    required this.itemBuilder,
    this.separatorBuilder,
    this.padding,
    this.scrollController,
    this.physics,
    this.header,
    this.footer,
    this.enableRefresh = true,
    this.enableLoadMore = true,
    this.customListLoadingBuilder,
    this.customListErrorBuilder,
    this.customListEmptyBuilder,
    this.customScrollViewBuilder,
    this.customSliverBuilder,
  });

  static const _defaultHeader = ClassicHeader(
    dragText: '下拉刷新',
    armedText: '释放刷新',
    readyText: '刷新中...',
    processingText: '刷新中...',
    processedText: '刷新成功',
    noMoreText: '没有更多了',
    failedText: '刷新失败',
    messageText: '上一次刷新时间 %T',
  );

  static const _defaultFooter = ClassicFooter(
    dragText: '上拉加载更多',
    armedText: '释放加载',
    readyText: '加载中...',
    processingText: '加载中...',
    processedText: '加载成功',
    noMoreText: '没有更多了',
    failedText: '加载失败',
    messageText: '上一次加载时间 %T',
  );

  @override
  Widget build(BuildContext context) {
    return GetCtrlInit(
      controller: refresCtrl,
      tag: "PageRefreshableWidget_${refresCtrl.hashCode}",
      child: PageStatusWidget(
        controller: refresCtrl.pageCtrl,
        customLoadingBuilder: customListLoadingBuilder,
        customErrorBuilder: customListErrorBuilder,
        customEmptyBuilder: customListEmptyBuilder,
        childBuilder: _buildEasyRefresh,
      ),
    );
  }

  Widget _buildEasyRefresh() {
    final headerIndicator = header ?? _defaultHeader;
    final footerIndicator = footer ?? _defaultFooter;

    if (customSliverBuilder != null) {
      return EasyRefresh.builder(
        controller: refresCtrl.listCtrl,
        header: headerIndicator,
        footer: footerIndicator,
        onRefresh: enableRefresh ? refresCtrl.doRefresh : null,
        onLoad:
            enableLoadMore && refresCtrl.hasMore ? refresCtrl.loadMore : null,
        childBuilder: (context, physics) => CustomScrollView(
          physics: physics,
          slivers: customSliverBuilder!(),
        ),
      );
    }

    return EasyRefresh(
      controller: refresCtrl.listCtrl,
      header: headerIndicator,
      footer: footerIndicator,
      onRefresh: enableRefresh ? refresCtrl.doRefresh : null,
      onLoad: enableLoadMore && refresCtrl.hasMore ? refresCtrl.loadMore : null,
      child: customScrollViewBuilder?.call() ?? _buildListView(),
    );
  }

  Widget _buildListView() {
    final items = refresCtrl.items;
    if (separatorBuilder != null) {
      return ListView.separated(
        controller: scrollController,
        physics: physics,
        padding: padding,
        itemCount: items.length,
        itemBuilder: _buildItem,
        separatorBuilder: (context, index) => separatorBuilder!(items, index),
      );
    }
    return ListView.builder(
      controller: scrollController,
      physics: physics,
      padding: padding,
      itemCount: items.length,
      itemBuilder: _buildItem,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final items = refresCtrl.items;
    if (index >= 0 && index < items.length) {
      return itemBuilder(items, items[index], index);
    }
    return const SizedBox.shrink();
  }
}
