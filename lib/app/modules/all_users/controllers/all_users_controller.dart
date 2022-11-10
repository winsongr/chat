import 'dart:convert';

import 'package:chat/app/data/api.dart';
import 'package:chat/app/data/models/user_model.dart';
import 'package:chat/app/utils/exports.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AllUsersController extends GetxController {
  //TODO: Implement AllUsersController
  RxList<UserModel> allUsers = RxList<UserModel>();

  final count = 0.obs;
  @override
  void onInit() {
    loadUsers().then((users) {
      allUsers.addAll(users);
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
          alllUsers.add(userModel);
        }
        return alllUsers;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }
}
