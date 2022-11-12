import 'package:chat/app/modules/chat/views/widgets/chat_bubble_widget.dart';
import 'package:chat/app/modules/home/controllers/home_controller.dart';
import 'package:chat/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';

import 'package:get/get.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  ChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: Get.width * 0.12,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Get.offAllNamed(Routes.HOME);
              },
            ),
          ),
          titleSpacing: 0,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width * 0.02,
              ),
              Obx(
                () => RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                      text: controller.userLoading.value
                          ? ''
                          : controller.userModel?.name?.toUpperCase() ?? 'User',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.width * 0.04,
                      ),
                    ),
                    const TextSpan(text: '\n'),
                    TextSpan(
                      text: 'Online',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.normal,
                        fontSize: Get.width * 0.028,
                      ),
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Obx(
              () => Expanded(
                child: controller.isloading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : GestureDetector(
                        onTap: () => FocusScope.of(context).unfocus(),
                        child: _chatList(context),
                      ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.03,
                vertical: Get.height * 0.005,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 0,
                  ),
                ],
              ),
              child: TextField(
                controller: controller.messageController,
                style: TextStyle(
                  fontSize: Get.width * 0.04,
                  height: Get.height * 0.002,
                  decoration: TextDecoration.none,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  fillColor: Colors.black,
                  focusColor: Colors.transparent,
                  hintText: 'Send a message',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    iconSize: Get.width * 0.05,
                    disabledColor: Colors.grey,
                    onPressed: () {
                      controller.sendMessage();
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _chatList(BuildContext context) {
    if (controller.messages.isEmpty) {
      return const Center(
        child: Text("No Messages"),
      );
    } else {
      return ListView.separated(
        itemCount: controller.messages.length,
        reverse: false,
        shrinkWrap: false,
        controller: controller.scrollController,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.transparent,
            height: Get.height * 0.0,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          if (controller.messages[index].userId ==
              controller.currentUser.value) {
            return ChatBubbleWidget(
              bubbleAlignment: Alignment.topRight,
              bubbleType: BubbleType.sendBubble,
              message: controller.messages[index].content,
            );
          } else {
            return ChatBubbleWidget(
              bubbleAlignment: Alignment.topLeft,
              bubbleType: BubbleType.receiverBubble,
              message: controller.messages[index].content,
            );
          }
        },
      );
    }
  }
}
