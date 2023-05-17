import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kuhoo/core/user.dart';
import 'package:kuhoo/data/user_data.dart';

class UserDataSourceImpl implements UserDataSource {
  final String baseUrl = 'https://reqres.in/api';

  @override
  Future<List<User>> fetchUsers(int page, int limit) async {
    final response =
        await http.get(Uri.parse('$baseUrl/users?page=$page&limit=$limit'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      final List<User> users = [];
      for (var userData in data['data']) {
        final user = User(
          id: userData['id'],
          email: userData['email'],
          firstName: userData['first_name'],
          lastName: userData['last_name'],
          avatar: userData['avatar'],
        );
        users.add(user);
      }
      return users;
    } else {
      throw Exception('Failed to fetch users');
    }
  }

  @override
  Future<User> fetchUserDetails(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final user = User(
        id: data['data']['id'],
        email: data['data']['email'],
        firstName: data['data']['first_name'],
        lastName: data['data']['last_name'],
        avatar: data['data']['avatar'],
      );
      return user;
    } else {
      throw Exception('Failed to fetch user details');
    }
  }
}
