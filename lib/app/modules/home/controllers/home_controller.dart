import 'dart:convert';

import 'package:chat/app/data/api.dart';
import 'package:chat/app/data/models/chat_room_model.dart';
import 'package:chat/app/data/models/user_model.dart';
import 'package:chat/app/routes/app_pages.dart';
import 'package:chat/app/utils/box.dart';
import 'package:chat/app/utils/helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  Box box = Box();
  final RxBool isloading = false.obs;
  RxList<ChatRoomModel> allChats = RxList<ChatRoomModel>();
  @override
  void onInit() async {
    isloading.value = true;
    await loadChat().then((chats) {
      allChats.addAll(chats);
      isloading.value = false;
    });
    super.onInit();
  }

  logout() async {
    Box().boxRemove();
    Get.offAndToNamed(Routes.SPLASH);
  }

  allUsers() {
    Get.toNamed(Routes.ALL_USERS);
  }

  Future<UserModel?> getuserById(uid) async {
    var url = Uri.parse(ApiConst.getuserid + uid);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['data']['data'] != null) {
        for (var user in data['data']['data']) {
          var userModel = UserModel.fromJson(user);
          // print(userModel.runtimeType);
          // return userModel;
        }
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<List<ChatRoomModel>> loadChat() async {
    allChats.value = [];
    var url = Uri.parse(ApiConst.allchat + '${box.boxread()}');
    http.Response response = await http.get(url);
    List<ChatRoomModel> allChatRooms = [];
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['data']['data'] != null) {
        for (var chat in data['data']['data']) {
          var chatModel = ChatRoomModel.fromJson(chat);
          allChatRooms.add(chatModel);
        }
        return allChatRooms;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }
}
