import 'package:ediscount/models/user.dart';

import '../network/user_service.dart';

class UserRepository {
  final UserService userService;

  UserRepository(this.userService);

  Future<UserResponse> getUser(String token) async {
    final response = await userService.getUser(token);
    return response;
  }

  Future<LogoutResponse> logout(String token) async {
    final response = await userService.logout(token);
    return response;
  }

  Future<ChangePasswordResponse> changePassword(String token, String password, String newPass, String retype) async {
    final response = await userService.changePassword(token, {
      "password": password,
      "newPass": newPass,
      "retype": retype
    });
    return response;
  }

  Future<ChangeNameResponse> ChangeName(String token, String name) async {
    final response = await userService.changeName(token, {
      "name": name
    });
    return response;
  }
}