import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../config/theme/theme_extensions.dart';
import '../service/theme_service.dart';

/// 自定义主题切换按钮
class ThemeToggleButton extends StatefulWidget {
  final double size;
  final Duration animationDuration;

  const ThemeToggleButton({
    super.key,
    this.size = 40,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<ThemeToggleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.8), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.8, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (ThemeService.to.isDarkMode) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    if (ThemeService.to.isDarkMode) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    ThemeService.to.toggleDarkMode();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Obx(() {
      final isDark = ThemeService.to.isDarkMode;

      return GestureDetector(
        onTap: _onTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: widget.size.w,
                height: widget.size.w,
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(widget.size / 2),
                  border: Border.all(color: colors.border, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: (isDark ? Colors.black : Colors.grey)
                          .withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Transform.rotate(
                  angle: _rotationAnimation.value * 3.14159,
                  child: _buildIcon(isDark),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildIcon(bool isDark) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: isDark ? _buildMoonIcon() : _buildSunIcon(),
    );
  }

  Widget _buildSunIcon() {
    return Icon(
      Icons.wb_sunny_rounded,
      key: const ValueKey('sun'),
      size: widget.size * 0.55,
      color: const Color(0xFFF59E0B),
    );
  }

  Widget _buildMoonIcon() {
    return Icon(
      Icons.nightlight_round,
      key: const ValueKey('moon'),
      size: widget.size * 0.55,
      color: const Color(0xFF8B5CF6),
    );
  }
}
