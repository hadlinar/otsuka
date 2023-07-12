import 'package:ediscount/models/user.dart';

import '../network/user_service.dart';

class UserRepository {
  final UserService userService;

  UserRepository(this.userService);

  Future<UserResponse> getUser(String token) async {
    final response = await userService.getUser(token);
    return response;
  }
}