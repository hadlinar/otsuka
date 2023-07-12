import '../../models/login.dart';
import '../network/login_service.dart';

class LoginRepository {
  final LoginService loginService;

  LoginRepository(this.loginService);

  Future<LoginResponse> login ({
    required String username,
    required String password
  }) async {
    final response = await loginService.login({
      "username": username,
      "password": password
    });

    return response;
  }
}