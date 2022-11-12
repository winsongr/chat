import 'dart:convert';

import 'package:chat/app/data/api.dart';
import 'package:chat/app/data/models/messages_model.dart';
import 'package:chat/app/data/models/user_model.dart';
import 'package:chat/app/utils/exports.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

class ChatController extends GetxController {
  late IO.Socket socket;
  var arg = Get.arguments;
  late TextEditingController messageController;
  final ScrollController scrollController = ScrollController();
  RxList<MessagesModel> messages = RxList<MessagesModel>();
  RxString currentUser = ''.obs;
  RxString otherUser = ''.obs;
  RxString chatId = ''.obs;
  UserModel? userModel;
  RxBool userLoading = false.obs;
  RxBool isloading = false.obs;
  @override
  void onInit() async {
    messageController = TextEditingController();

    await setValues();
    await initSocket();
    print(arg);
    _loadMessages();
    getUserById(otherUser.value);
    super.onInit();
  }

  Future<UserModel?> getUserById(uid) async {
    userLoading.value = true;
    var url = Uri.parse('${ApiConst.getuserid}$uid');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      userModel = UserModel.fromJson(data['data']['data']);
      userLoading.value = false;

      return userModel;
    } else {
      return null;
    }
  }

  setValues() {
    currentUser.value = arg["userId"];
    chatId.value = arg["chatId"];
    otherUser.value = arg['secondUserId'];
  }

  @override
  void dispose() {
    socket.disconnect();
    messageController.dispose();
    messages.value = [];
    super.dispose();
  }

  void sendMessage() async {
    String messageText = messageController.text;
    messageController.text = '';
    if (messageText != '') {
      var messagePost = {
        "roomId": chatId.value,
        "userId": currentUser.value,
        "content": "$messageText ",
        "contentType": "TEXT"
      };
      socket.emit("send", jsonEncode(messagePost));
    }
  }

  _loadMessages() async {
    isloading.value = true;
    messages.value = [];
    var url = Uri.parse('${ApiConst.allmsgs}${chatId.value}');
    http.Response response = await http.get(url);
    print(url);
    List<MessagesModel> allMsg = [];
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['data']['data'] != null) {
        for (var msg in data['data']['data']) {
          final messagesModel = MessagesModel.fromJson(msg);
          messages.add(messagesModel);
        }
      }
      isloading.value = false;

      return allMsg;
    } else {
      isloading.value = false;

      debugPrint('Error retrieving');
    }
  }

  Future<void> initSocket() async {
    debugPrint('Connecting to chat service');
    socket = IO.io(Socket.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    socket.emit("join", chatId.value);
    socket.on('send', (data) {
      _loadMessages();
      isloading.value = false;
    });
    socket.onConnect((_) {
      debugPrint('connected to websocket');
    });
  }
}
