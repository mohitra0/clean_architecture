import 'package:kuhoo/core/user.dart';
import 'package:kuhoo/data/user_data.dart';
import 'package:kuhoo/domain/user_repo.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<List<User>> getUsers(int page, int limit) async {
    return dataSource.fetchUsers(page, limit);
  }

  @override
  Future<User> getUserDetails(int userId) async {
    return dataSource.fetchUserDetails(userId);
  }
}
