import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/all_users_controller.dart';

class AllUsersView extends GetView<AllUsersController> {
  const AllUsersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
      ),
      body: Center(
        child: Text(
          'AllUsersView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
