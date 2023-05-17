import 'package:kuhoo/core/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers(int page, int limit);
  Future<User> getUserDetails(int userId);
}
