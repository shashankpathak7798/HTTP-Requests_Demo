import 'package:flutter/material.dart';

import './screen/home_screen.dart';
import './screen/single_user_screen.dart';
import './screen/all_users_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        SingleUserScreen.routeName: (ctx) => SingleUserScreen(),
        AllUsersScreen.routeName: (ctx) => AllUsersScreen(),
      },
    );
  }
}
