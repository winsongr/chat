import 'dart:convert';

import 'package:chat/app/data/api.dart';
import 'package:chat/app/data/models/create_chat_room_model.dart';
import 'package:chat/app/data/models/user_model.dart';
import 'package:chat/app/routes/app_pages.dart';
import 'package:chat/app/utils/box.dart';
import 'package:chat/app/utils/exports.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AllUsersController extends GetxController {
  RxList<UserModel> allUsers = RxList<UserModel>();
  final RxBool isloading = false.obs;
  Box box = Box();
  final RxBool loading = false.obs;
  @override
  void onInit() {
    isloading.value = true;

    loadUsers().then((users) {
      allUsers.value = [];

      allUsers.addAll(users);
      isloading.value = false;
    });

    super.onInit();
  }

  Future<List<UserModel>> loadUsers() async {
    var url = Uri.parse(ApiConst.alluser);
    http.Response response = await http.get(url);
    List<UserModel> alllUsers = [];
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['data']['data'] != null) {
        for (var user in data['data']['data']) {
          var userModel = UserModel.fromJson(user);
          if (userModel.id != box.boxread()) {
            alllUsers.add(userModel);
          }
        }
        return alllUsers;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  chatUser(String uid) async {
    loading.value = true;

    var url = Uri.parse(ApiConst.createChat);
    Map data = {"userId": "${box.boxread()}", "secondUserId": uid};
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      var resdata = json.decode(response.body);
      var res = CreateChatRoomModel.fromJson(resdata['data']['data']);
      Get.offAllNamed(Routes.CHAT, arguments: {
        'secondUserId': uid,
        "userId": box.boxread(),
      "chatId": "${res.chatId}"
      });
    }
    loading.value = false;
  }
}
