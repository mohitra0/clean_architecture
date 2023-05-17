import 'package:flutter/material.dart';
import 'package:kuhoo/data/user_data.dart';
import 'package:kuhoo/domain/user_repo.dart';
import 'package:kuhoo/domain/user_repo_impl.dart';
import 'package:provider/provider.dart';
import 'package:kuhoo/data/user_data_impl.dart';
import 'package:kuhoo/view/user_details_page.dart';
import 'package:kuhoo/view/users_page.dart';
import 'package:kuhoo/provider/user_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserDataSource>(
          create: (_) => UserDataSourceImpl(),
        ),
        Provider<UserRepository>(
          create: (context) => UserRepositoryImpl(
            Provider.of<UserDataSource>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(
            Provider.of<UserRepository>(context, listen: false),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'User App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => UsersPage(),
          '/userDetails': (context) => UserDetailsPage(),
        },
      ),
    );
  }
}
