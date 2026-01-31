import 'package:flutter/material.dart';

/// 加载中组件（不再嵌套 Scaffold，方便作为任意子组件复用）
class LoadingWidget extends StatelessWidget {
  final String loadingText;
  final Color? textColor;
  final Color? indicatorColor;
  final double? indicatorSize;

  const LoadingWidget({
    super.key,
    this.loadingText = '加载中...',
    this.textColor,
    this.indicatorColor,
    this.indicatorSize,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: indicatorSize ?? 24,
            height: indicatorSize ?? 24,
            child: CircularProgressIndicator(
              color: indicatorColor ?? Theme.of(context).primaryColor,
              strokeWidth: 2.0,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            loadingText,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: textColor ?? Colors.grey[600],
                ),
          ),
        ],
      ),
    );
  }
}
