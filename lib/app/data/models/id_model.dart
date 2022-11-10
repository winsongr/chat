// To parse this JSON data, do
//
//     final idModel = idModelFromJson(jsonString);

import 'dart:convert';

IdModel idModelFromJson(String str) => IdModel.fromJson(json.decode(str));

String idModelToJson(IdModel data) => json.encode(data.toJson());

class IdModel {
  IdModel({
    this.insertedId,
  });

  String? insertedId;

  factory IdModel.fromJson(Map<String, dynamic> json) => IdModel(
        insertedId: json["InsertedID"],
      );

  Map<String, dynamic> toJson() => {
        "InsertedID": insertedId,
      };
}
