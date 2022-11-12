// To parse this JSON data, do
//
//     final createChatRoomModel = createChatRoomModelFromJson(jsonString);

import 'dart:convert';

CreateChatRoomModel createChatRoomModelFromJson(String str) => CreateChatRoomModel.fromJson(json.decode(str));

String createChatRoomModelToJson(CreateChatRoomModel data) => json.encode(data.toJson());

class CreateChatRoomModel {
    CreateChatRoomModel({
        this.chatId,
        this.users,
        this.isGroup,
        this.latestMessage,
        this.latestMessageId,
        this.userId,
        this.chatName,
    });

    String? chatId;
    List<String>? users;
    bool? isGroup;
    String? latestMessage;
    String? latestMessageId;
    String? userId;
    String? chatName;

    factory CreateChatRoomModel.fromJson(Map<String, dynamic> json) => CreateChatRoomModel(
        chatId: json["chatId"],
        users: List<String>.from(json["users"].map((x) => x)),
        isGroup: json["isGroup"],
        latestMessage: json["latestMessage"],
        latestMessageId: json["latestMessageId"],
        userId: json["userId"],
        chatName: json["chatName"],
    );

    Map<String, dynamic> toJson() => {
        "chatId": chatId,
        "users": List<dynamic>.from(users!.map((x) => x)),
        "isGroup": isGroup,
        "latestMessage": latestMessage,
        "latestMessageId": latestMessageId,
        "userId": userId,
        "chatName": chatName,
    };
}
