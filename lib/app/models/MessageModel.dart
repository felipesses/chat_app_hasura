import 'dart:convert';

import 'package:chat_hasura/app/models/UserModel.dart';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  String content;
  int id;
  UserModel user;

  MessageModel({
    this.content,
    this.id,
    this.user,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        content: json["content"] == null ? null : json["content"],
        id: json["id"] == null ? null : json["id"],
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "content": content == null ? null : content,
        "id": id == null ? null : id,
        "user": user == null ? null : user.toJson(),
      };

  static List<MessageModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => MessageModel.fromJson(item)).toList();
  }
}
