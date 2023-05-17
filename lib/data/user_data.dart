import 'package:kuhoo/core/user.dart';

abstract class UserDataSource {
  Future<List<User>> fetchUsers(int page, int limit);
  Future<User> fetchUserDetails(int userId);
}
