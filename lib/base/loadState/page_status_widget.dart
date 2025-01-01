import 'package:flutter/material.dart';
import 'package:flutter_getx_base_project/base/loadState/%20loading_widget.dart';
import 'abstract_page_status.dart';
import 'empty_status.dart';
import 'error_status.dart';

class PageStatusWidget extends StatelessWidget {
  final Widget Function() childBuilder;
  final AbstractPageStatus logic;

  const PageStatusWidget({
    super.key, 
    required this.logic, 
    required this.childBuilder
  });

  @override
  Widget build(BuildContext context) {
    return _buildByState(logic.state);
  }

  Widget _buildByState(PageState state) {
    switch (state) {
      case PageState.LOADING:
        return const LoadingWidget();
      case PageState.SUCCESS:
        return childBuilder();
      case PageState.ERROR:
        return ErrorStatusWidget(
          onRetry: () {
            logic.state = PageState.LOADING;
            logic.loadData();
          },
        );
      case PageState.EMPTY:
        return const EmptyStatusWidget(
          emptyType: EmptyStatusType.noMessage
        );
    }
  }
}