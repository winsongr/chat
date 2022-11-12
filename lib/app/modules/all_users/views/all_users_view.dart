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
        body: Obx(
          () => controller.isloading.value
              ? const Center(child: CircularProgressIndicator())
              : controller.allUsers.isEmpty
                  ? const Center(
                      child: Text(
                      'No Users Found',
                      style: TextStyle(fontSize: 20),
                    ))
                  : ListView.builder(
                      itemCount: controller.allUsers.length,
                      itemBuilder: (BuildContext context, int index) {
                        var user = controller.allUsers[index];
                        print(user.id);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: ListTile(
                              title: Text(user.name ?? ''),
                              subtitle: Text(user.email ?? ''),
                              trailing: IconButton(
                                  icon: const Icon(Icons.chat_bubble),
                                  onPressed: controller.loading.value == false
                                      ? () {
                                          controller.chatUser(user.id!);
                                        }
                                      : null),
                            ),
                          ),
                        );
                      },
                    ),
        ));
  }
}
