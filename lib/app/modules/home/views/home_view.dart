import 'package:chat/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.allUserChats();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () async {
                controller.logout();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Obx(
        () => controller.isloading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : controller.allChats.isEmpty
                ? const Center(
                    child: Text("No Chats"),
                  )
                : ListView.builder(
                    itemCount: controller.allChats.length,
                    itemBuilder: ((context, index) {
                      var chat = controller.allChats[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            title: Text(chat.chatName?.toUpperCase()??''),
                            // subtitle: Text(),
                            onTap: () {
                              Get.toNamed(Routes.CHAT, arguments: {
                                'otherUserName':chat.chatName,
                                'secondUserId': chat.userId,
                                "userId": controller.box.boxread(),
                                "chatId": "${chat.chatId}"
                              });
                            },
                          ),
                        ),
                      );
                    }),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.allUsersScreen();
        },
        child: const Icon(Icons.contact_mail),
      ),
    );
  }
}
