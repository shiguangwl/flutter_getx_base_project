import '../model/adapters.dart';
import '../model/user_model.dart';
import '../core/base_repository.dart';

/// 用户仓库
/// 管理当前登录用户信息
class UserRepository extends BaseRepository<UserModel> {
  static const _currentUserKey = 'current_user';

  UserRepository() : super(Boxes.user.name);

  UserModel? getCurrentUser() => get(_currentUserKey);

  Future<void> saveCurrentUser(UserModel user) => put(_currentUserKey, user);

  Future<void> clearCurrentUser() => delete(_currentUserKey);

  bool isLoggedIn() => containsKey(_currentUserKey);
}
