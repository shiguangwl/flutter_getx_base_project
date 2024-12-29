import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import ' loading_widget.dart';
import 'abstract_page_status.dart';
import 'empty_status.dart';

class PageStatusWidget extends StatelessWidget {
  final Widget Function() childBuilder;
  final AbstractPageStatus logic;

  const PageStatusWidget(
      {super.key, required this.logic, required this.childBuilder});

  @override
  Widget build(BuildContext context) {
    switch (logic.state) {
      case PageState.LOADING:
        return const LoadingWidget();
      case PageState.SUCCESS:
        return childBuilder();
      case PageState.ERROR:
        return EmptyStatusWidget(
          emptyType: EmptyStatusType.fail,
          refreshTitle: '重新加载',
          width: 1.sw,
          height: 1.sh,
          onTap: () {
            /// 重新请求数据
            logic.getData();
          },
        );
      case PageState.EMPTY:
        return const EmptyStatusWidget(emptyType: EmptyStatusType.noMessage);
    }
  }
}