import 'sp_storage.dart';
import 'database/database_service.dart';

/// 持久化服务
/// 统一管理SharedPreferences和数据库
class PersistentService {
  static final PersistentService _instance = PersistentService._internal();
  
  factory PersistentService() => _instance;
  
  PersistentService._internal();
  
  final DatabaseService _databaseService = DatabaseService();
  
  bool _isInitialized = false;
  
  /// 初始化持久化服务
  Future<void> init() async {
    if (_isInitialized) return;
    
    // 初始化SharedPreferences
    await SPStorage.init();
    
    // 初始化数据库
    await _databaseService.init();
    
    _isInitialized = true;
  }
  
  /// 关闭持久化服务
  Future<void> close() async {
    if (!_isInitialized) return;
    
    // 关闭数据库
    await _databaseService.close();
    
    _isInitialized = false;
  }
  
  /// 获取数据库服务
  DatabaseService get database {
    if (!_isInitialized) {
      throw Exception('PersistentService not initialized. Call init() first.');
    }
    return _databaseService;
  }
  
  /// 检查持久化服务是否已初始化
  bool get isInitialized => _isInitialized;
} 