import 'package:chat/app/data/models/user_model.dart';
import 'package:chat/app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
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
        title: const Text('HomeView'),
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

                      var otherUser;
                      if (chat.users!.first != controller.box.boxread()) {
                        otherUser = chat.users!.first;
                      } else {
                        otherUser = chat.users!.last;
                      }

                      return ListTile(
                        title: Text(otherUser??''),
                        // subtitle: Text(),
                        onTap: () {
                          Get.toNamed(Routes.CHAT, arguments: {
                            'secondUserId': otherUser,
                            "userId": controller.box.boxread(),
                            "chatId": "${chat.chatid}"
                          });
                        },
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
