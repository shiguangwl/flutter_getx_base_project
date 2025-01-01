import 'package:get/get.dart';

class AuthService extends GetxService {
  final _isLoggedIn = false.obs;
  
  bool get isLoggedIn => _isLoggedIn.value;
  
  void login(String username, String password) {
    _isLoggedIn.value = true;
  }
  
  void logout() {
    _isLoggedIn.value = false;
  }
}