import 'dart:convert';

import 'package:chat/app/data/api.dart';
import 'package:chat/app/data/models/chat_room_model.dart';
import 'package:chat/app/data/models/user_model.dart';
import 'package:chat/app/routes/app_pages.dart';
import 'package:chat/app/utils/box.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  Box box = Box();
  final RxBool isloading = false.obs;
  final RxBool isUserloading = false.obs;
  RxList<ChatRoomModel> allChats = RxList<ChatRoomModel>();
  RxList<UserModel> allUsers = RxList<UserModel>();

  @override
  void onInit() async {
    print("home init");
    super.onInit();
  }

  allUserChats() async {
    allChats.value = [];
    isloading.value = true;
    await loadChat().then((chats) {
      allChats.addAll(chats);
    });

    isloading.value = false;
  }

  logout() async {
    Box().boxRemove();
    Get.offAndToNamed(Routes.SPLASH);
  }

  allUsersScreen() {
    Get.toNamed(Routes.ALL_USERS);
  }

  // userById(List uid) async {
  //   // isUserloading.value = true;

  //   var currentUser;
  //   if (uid.first != box.boxread()) {
  //     currentUser = uid.first;
  //   } else {
  //     currentUser = uid.last;
  //   }
  //   return currentUser;
  //   // userModel.value = await getUserById(currentUser);
  //   // isUserloading.value = false;
  // }

 Future getUserById(uid) async {
    var url = Uri.parse('${ApiConst.getuserid}$uid');
    UserModel userModel;
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      userModel = UserModel.fromJson(data['data']['data']);
      return userModel.name;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  Future<List<ChatRoomModel>> loadChat() async {
    allChats.value = [];
    var url = Uri.parse('${ApiConst.allchat}${box.boxread()}');
     print(url);
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
