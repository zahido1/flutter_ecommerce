// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

CommentModel commentModelFromJson(String str) =>
    CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  List<Comment> comments;
  int total;
  int skip;
  int limit;

  CommentModel({
    required this.comments,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}

class Comment {
  int id;
  String body;
  int postId;
  User user;

  Comment({
    required this.id,
    required this.body,
    required this.postId,
    required this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        body: json["body"],
        postId: json["postId"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "postId": postId,
        "user": user.toJson(),
      };
}

class User {
  int id;
  String username;

  User({
    required this.id,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
      };
}
