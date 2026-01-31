import 'package:flutter/material.dart';

import '../../../common/base/view/base_view.dart';
import '../../../routes/router.dart';
import '../../demo/_widgets/demo_item_widget.dart';
import '../../demo/_widgets/demo_section_header.dart';
import 'home_logic.dart';

/// 首页 - 功能演示入口
class HomePage extends BaseView<HomePageLogic> {
  const HomePage({super.key});

  @override
  Widget buildContent() {
    return Scaffold(
      appBar: AppBar(title: const Text('功能演示'), centerTitle: true),
      body: ListView(
        children: [
          _buildHeader(),
          // 基础架构演示
          const DemoSectionHeader(title: '基础架构', icon: Icons.foundation),
          const DemoItemWidget(
            title: 'BaseView 演示',
            description: '基础页面结构、状态管理、Scaffold 配置',
            icon: Icons.view_quilt,
            routeName: AppRoutes.demoBaseView,
          ),
          const DemoItemWidget(
            title: 'RefreshableView 演示',
            description: '下拉刷新、上拉加载、头部固定等多种配置',
            icon: Icons.refresh,
            routeName: AppRoutes.demoRefreshable,
          ),
          const DemoItemWidget(
            title: 'PageStatus 演示',
            description: '页面状态管理：加载中、空数据、错误、成功',
            icon: Icons.toggle_on,
            routeName: AppRoutes.demoPageStatus,
          ),
          // 网络层演示
          const DemoSectionHeader(title: '网络层', icon: Icons.cloud),
          const DemoItemWidget(
            title: '网络请求演示',
            description: 'GET/POST/缓存/重试/取消/Token刷新',
            icon: Icons.http,
            routeName: AppRoutes.demoNetwork,
          ),
          // 持久化演示
          const DemoSectionHeader(title: '持久化', icon: Icons.storage),
          const DemoItemWidget(
            title: 'Hive 演示',
            description: '键值对存储、类型化Box、CRUD操作',
            icon: Icons.inventory_2,
            routeName: AppRoutes.demoHive,
          ),
          // 路由演示
          const DemoSectionHeader(title: '路由导航', icon: Icons.route),
          const DemoItemWidget(
            title: '路由演示',
            description: '基础跳转、参数传递、中间件验证',
            icon: Icons.navigation,
            routeName: AppRoutes.demoRouting,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6936FF), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.rocket_launch, size: 40, color: Colors.white),
          SizedBox(height: 12),
          Text(
            'Flutter 项目脚手架',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '点击下方卡片查看各功能模块的使用演示',
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
