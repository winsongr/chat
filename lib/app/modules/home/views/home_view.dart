import 'package:chat/app/data/models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        actions: [
          IconButton(
              onPressed: () async {
                controller.logout();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Obx(() => controller.isloading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : controller.allChats.isEmpty
              ? Center(
                  child: Text("No Chats"),
                )
              : ListView.builder(
                  itemCount: controller.allChats.length,
                  itemBuilder: ((context, index) {
                    var chat = controller.allChats[index];
                    var userModel =
                        controller.getuserById(chat.users!.last);
                    return ListTile(
                      title: Text(chat.chatId ?? ''),
                    );
                  }))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.allUsers();
        },
        child: const Icon(Icons.contact_mail),
      ),
    );
  }
}
