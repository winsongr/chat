// To parse this JSON data, do
//
//     final chatRoomModel = chatRoomModelFromJson(jsonString);

import 'dart:convert';

ChatRoomModel chatRoomModelFromJson(String str) => ChatRoomModel.fromJson(json.decode(str));

String chatRoomModelToJson(ChatRoomModel data) => json.encode(data.toJson());

class ChatRoomModel {
    ChatRoomModel({
        this.id,
        this.chatid,
        this.chatname,
        this.isgroup,
        this.latestmessage,
        this.latestmessageid,
        this.userid,
        this.users,
        this.usersInfo,
    });

    String? id;
    String? chatid;
    String? chatname;
    bool? isgroup;
    String? latestmessage;
    String? latestmessageid;
    String? userid;
    List<String>? users;
    List<UsersInfo>? usersInfo;

    factory ChatRoomModel.fromJson(Map<String, dynamic> json) => ChatRoomModel(
        id: json["_id"],
        chatid: json["chatid"],
        chatname: json["chatname"],
        isgroup: json["isgroup"],
        latestmessage: json["latestmessage"],
        latestmessageid: json["latestmessageid"],
        userid: json["userid"],
        users: List<String>.from(json["users"].map((x) => x)),
        usersInfo: List<UsersInfo>.from(json["users_info"].map((x) => UsersInfo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "chatid": chatid,
        "chatname": chatname,
        "isgroup": isgroup,
        "latestmessage": latestmessage,
        "latestmessageid": latestmessageid,
        "userid": userid,
        "users": List<dynamic>.from(users!.map((x) => x)),
        "users_info": List<dynamic>.from(usersInfo!.map((x) => x.toJson())),
    };
}

class UsersInfo {
    UsersInfo({
        this.id,
        this.email,
        this.usersInfoId,
        this.name,
    });

    String? id;
    String? email;
    String? usersInfoId;
    String? name;

    factory UsersInfo.fromJson(Map<String, dynamic> json) => UsersInfo(
        id: json["_id"],
        email: json["email"],
        usersInfoId: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "id": usersInfoId,
        "name": name,
    };
}
