import 'package:flutter/material.dart';
import 'package:letus/app/app.locator.dart';
import 'package:letus/services/user_service.dart';

class UserView extends StatelessWidget {
  final UserService _userService = locator<UserService>();

  UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('User'),
      ),
    );
  }
}
