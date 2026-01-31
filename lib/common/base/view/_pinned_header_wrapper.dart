import 'package:flutter/material.dart';

/// 固定头部包装器，负责头部固定效果的实现
class PinnedHeaderWrapper extends StatefulWidget {
  /// 主要内容（包含可刷新列表）
  final Widget child;

  /// 固定头部组件
  final Widget pinnedHeader;

  /// 固定头部高度
  final double pinnedHeaderHeight;

  const PinnedHeaderWrapper({
    super.key,
    required this.child,
    required this.pinnedHeader,
    required this.pinnedHeaderHeight,
  });

  @override
  createState() => _PinnedHeaderWrapperState();
}

class _PinnedHeaderWrapperState extends State<PinnedHeaderWrapper> {
  late final ValueNotifier<double> _pinnedHeaderOpacity =
      ValueNotifier<double>(0.0);

  @override
  void dispose() {
    _pinnedHeaderOpacity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 主要的刷新内容
        NotificationListener<ScrollNotification>(
          onNotification: _onScrollNotification,
          child: widget.child,
        ),
        // 固定头部覆盖层
        _buildPinnedHeaderOverlay(),
      ],
    );
  }

  Widget _buildPinnedHeaderOverlay() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: widget.pinnedHeaderHeight,
      child: ValueListenableBuilder<double>(
        valueListenable: _pinnedHeaderOpacity,
        builder: (context, opacity, child) {
          return Opacity(
            opacity: opacity,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: opacity > 0.1
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1 * opacity),
                          offset: const Offset(0, 2),
                          blurRadius: 4 * opacity,
                        ),
                      ]
                    : null,
              ),
              child: widget.pinnedHeader,
            ),
          );
        },
      ),
    );
  }

  bool _onScrollNotification(ScrollNotification notification) {
    final scrollOffset = notification.metrics.pixels;
    final headerHeight = widget.pinnedHeaderHeight;

    final fadeStartOffset = 0;
    final fadeEndOffset = headerHeight * 0.7;

    double opacity = 0.0;
    if (scrollOffset >= fadeEndOffset) {
      opacity = 1.0;
    } else if (scrollOffset >= fadeStartOffset) {
      // 使用线性渐变，避免复杂曲线导致的视觉不稳定
      final progress =
          (scrollOffset - fadeStartOffset) / (fadeEndOffset - fadeStartOffset);
      opacity = progress.clamp(0.0, 1.0);
    } else {
      // 确保在渐变区间外完全透明
      opacity = 0.0;
    }

    // 增加更新阈值，减少渲染频率，避免闪烁
    if ((_pinnedHeaderOpacity.value - opacity).abs() > 0.01) {
      _pinnedHeaderOpacity.value = opacity;
    }

    return false;
  }
}
