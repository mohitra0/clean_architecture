import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kuhoo/core/user.dart';
import 'package:kuhoo/provider/user_provider.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: FutureBuilder<List<User>>(
        future: userProvider.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error occurred: ${snapshot.error}'));
          }
          final users = snapshot.data;
          return ListView.builder(
            itemCount: users!.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text('${user.firstName} ${user.lastName}'),
                leading: Image.network(user.avatar),
                trailing: Text(user.email),
                onTap: () {
                  Navigator.pushNamed(context, '/userDetails',
                      arguments: user.id);
                },
              );
            },
          );
        },
      ),
    );
  }
}
