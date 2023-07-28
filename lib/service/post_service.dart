import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/constant/api_url.dart';
import 'package:flutter_ecommerce/model/post_model.dart';

import '../model/comment_model.dart';

class PostService {
  final String url = "$apiUrl/posts";
  Dio dio = Dio();

  Future<PostModel?> getPosts() async {
    try {
      final response = await dio.get<String>(url);
      if (response.statusCode == 200) {
        var posts = postModelFromJson(response.data!);
        return posts;
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }

  Future<PostModel?> getAllPosts() async {
    try {
      final response = await dio.get<String>("$url?limit=0");
      if (response.statusCode == 200) {
        var posts = postModelFromJson(response.data!);
        return posts;
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }

  Future<PostModel?> getMyPosts(int id) async {
    String myUrl = "$apiUrl/posts/user/$id";
    try {
      final response = await dio.get<String>(myUrl);
      if (response.statusCode == 200) {
        var posts = postModelFromJson(response.data!);
        return posts;
      }
    } catch (e) {
      throw Exception();
    }
    return null;
  }

  Future<CommentModel?> getPostComments(int id) async {
    String myUrl = "$apiUrl/posts/$id/comments";
    try {
      final response = await dio.get<String>(myUrl);
      if (response.statusCode == 200) {
        var comments = commentModelFromJson(response.data!);
        return comments;
      }
    } catch (e) {
      throw Exception();
    }
    return null;
  }

  Future<Comment?> addComment(String text, int postId, int userId) async {
    try {
      final response = await dio.post('$apiUrl/comments/add',
          data: json.encode({
            "body": text,
            "postId": postId,
            "userId": userId,
          }));
      if (response.statusCode == 200) {
        debugPrint("Success");
        final responseData = response.data;

        Comment comment = Comment(
          id: responseData['id'],
          body: responseData['body'],
          postId: responseData['postId'],
          user: User(
            id: responseData['user']['id'],
            username: responseData['user']['username'],
          ),
        );
        return comment;
      }
    } catch (error) {
      debugPrint('Add Comment Error: $error');
    }
    return null;
  }

  Future<List<Post>?> searchPosts(String query) async {
    String searchProduct = "$apiUrl/posts/search?q=$query";
    try {
      final response = await dio.get<String>(searchProduct);
      if (response.statusCode == 200) {
        var posts = postModelFromJson(response.data!);
        return posts.posts;
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }
}
