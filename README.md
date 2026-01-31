# Flutter GetX 快速开发脚手架

基于 Flutter 3.x + GetX 的企业级应用开发模板。

## 快速开始

```bash
# 安装依赖
flutter pub get

# 生成代码 (json_serializable, freezed, retrofit 等)
dart run build_runner build --delete-conflicting-outputs

# 运行应用
flutter run --dart-define-from-file=env/dev.json
```

## 项目结构

```
lib/
├── common/       # 公共工具类
├── config/       # 应用配置
├── constant/     # 常量定义
├── i18n/         # 国际化
├── middleware/   # 路由中间件
├── network/      # 网络层 (Dio + Retrofit)
├── pages/        # 页面模块
├── persistent/   # 本地持久化 (Hive)
├── routes/       # 路由配置
├── service/      # 业务服务
└── widgets/      # 通用组件
```

## 环境配置

环境配置文件位于 `env/` 目录：

- `dev.json` - 开发环境
- `test.json` - 测试环境
- `prod.json` - 生产环境

## 脚本工具

```bash
# 生成页面模块
dart run scripts/generate_page.dart

# 生成资源引用
sh scripts/generate_resources.sh
```

## 技术栈

| 功能     | 依赖               |
| -------- | ------------------ |
| 状态管理 | GetX               |
| 网络请求 | Dio + Retrofit     |
| 本地存储 | Hive               |
| 屏幕适配 | flutter_screenutil |

# 文档待完善
