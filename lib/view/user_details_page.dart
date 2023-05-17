import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kuhoo/core/user.dart';
import 'package:kuhoo/provider/user_provider.dart';

class UserDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)!.settings.arguments as int;
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: FutureBuilder<User>(
        future: userProvider.getUserDetails(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error occurred: ${snapshot.error}'));
          }
          final user = snapshot.data;
          return ListTile(
            title: Text('${user!.firstName} ${user.lastName}'),
            leading: Image.network(user.avatar),
            trailing: Text(user.email),
            onTap: () {
              Navigator.pushNamed(context, '/userDetails', arguments: user.id);
            },
          );
        },
      ),
    );
  }
}
