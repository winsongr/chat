// To parse this JSON data, do
//
//     final chatRoomModel = chatRoomModelFromJson(jsonString);

import 'dart:convert';

ChatRoomModel chatRoomModelFromJson(String str) => ChatRoomModel.fromJson(json.decode(str));

String chatRoomModelToJson(ChatRoomModel data) => json.encode(data.toJson());

class ChatRoomModel {
    ChatRoomModel({
        this.chatId,
        this.users,
        this.isGroup,
        this.latestMessage,
        this.latestMessageId,
        this.userId,
        this.chatName,
    });

    String? chatId;
    List<User>? users;
    bool? isGroup;
    String? latestMessage;
    String? latestMessageId;
    String? userId;
    String? chatName;

    factory ChatRoomModel.fromJson(Map<String, dynamic> json) => ChatRoomModel(
        chatId: json["chatId"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
        isGroup: json["isGroup"],
        latestMessage: json["latestMessage"],
        latestMessageId: json["latestMessageId"],
        userId: json["userId"],
        chatName: json["chatName"],
    );

    Map<String, dynamic> toJson() => {
        "chatId": chatId,
        "users": List<dynamic>.from(users!.map((x) => x.toJson())),
        "isGroup": isGroup,
        "latestMessage": latestMessage,
        "latestMessageId": latestMessageId,
        "userId": userId,
        "chatName": chatName,
    };
}

class User {
    User({
        this.id,
        this.name,
    });

    String? id;
    String? name;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
