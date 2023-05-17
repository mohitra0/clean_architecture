import 'package:flutter/foundation.dart';
import 'package:kuhoo/core/user.dart';
import 'package:kuhoo/domain/user_repo.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository userRepository;

  UserProvider(this.userRepository);

  List<User> _users = [];
  User? _userDetails;

  List<User> get users => _users;
  User? get userDetails => _userDetails;

  Future<List<User>> getUsers() async {
    if (_users.isNotEmpty) {
      return _users;
    }

    try {
      _users = await userRepository.getUsers(1, 10);
      notifyListeners();
      return _users;
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }

  Future<User> getUserDetails(int userId) async {
    if (_userDetails != null && _userDetails!.id == userId) {
      return _userDetails!;
    }

    try {
      _userDetails = await userRepository.getUserDetails(userId);
      notifyListeners();
      return _userDetails!;
    } catch (e) {
      throw Exception('Failed to fetch user details: $e');
    }
  }
}
