import 'dart:convert';

ChatRoomModel chatRoomModelFromJson(String str) =>
    ChatRoomModel.fromJson(json.decode(str));

String chatRoomModelToJson(ChatRoomModel data) => json.encode(data.toJson());

class ChatRoomModel {
  ChatRoomModel({
    this.chatId,
    this.users,
    this.isGroup,
    this.latestMessage,
    this.latestMessageId,
  });

  String? chatId;
  List<String>? users;
  bool? isGroup;
  String? latestMessage;
  String? latestMessageId;

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) => ChatRoomModel(
        chatId: json["chatId"],
        users: List<String>.from(json["users"].map((x) => x)),
        isGroup: json["isGroup"],
        latestMessage: json["latestMessage"],
        latestMessageId: json["latestMessageId"],
      );

  Map<String, dynamic> toJson() => {
        "chatId": chatId,
        "users": List<dynamic>.from(users!.map((x) => x)),
        "isGroup": isGroup,
        "latestMessage": latestMessage,
        "latestMessageId": latestMessageId,
      };
}
