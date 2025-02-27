import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'BaseView.dart';
import 'refreshable_controller.dart';

/// 支持下拉刷新和上拉加载更多的视图基类
abstract class RefreshableView<T extends RefreshableController> extends BaseView<T> {
  const RefreshableView({super.key});

  /// 构建列表项
  Widget buildListItem(BuildContext context, int index);
  
  /// 获取数据长度
  int getItemCount();

  @override
  Widget buildContent(BuildContext context) {
    return EasyRefresh(
      onRefresh: () async {
        await logic.onRefresh();
      },
      onLoad: () async {
        await logic.onLoadMore();
      },
      child: ListView.builder(
        itemCount: getItemCount(),
        itemBuilder: (context, index) => buildListItem(context, index),
      ),
    );
  }
} 