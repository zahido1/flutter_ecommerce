import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/login_model.dart';
import 'package:flutter_ecommerce/model/user_model.dart';

import '../constant/api_url.dart';

class UserService {
  Dio dio = Dio();
  final url = "$apiUrl/users";

  Future<int?> loginMethod(String username, String password) async {
    LoginModel login = LoginModel(username: username, password: password);
    try {
      final response =
          await dio.post('$apiUrl/auth/login', data: loginModelToJson(login));
      if (response.statusCode == 200) {
        debugPrint("Success");
        return response.data['id'];
      }
      return response.data;
    } catch (error) {
      debugPrint('Login Error: $error');
      return null;
    }
  }

  Future<UserModel?> getUsers() async {
    try {
      final response = await dio.get<String>(url);
      if (response.statusCode == 200) {
        var users = userModelFromJson(response.data!);
        return users;
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }

  Future<UserModel?> getAllUsers() async {
    try {
      final response = await dio.get<String>("$url?limit=0");
      if (response.statusCode == 200) {
        var users = userModelFromJson(response.data!);
        return users;
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }

  Future<User?> getUser(var id) async {
    try {
      final response = await dio.get("$url/$id");
      if (response.statusCode == 200) {
        var user = User.fromJson(response.data);
        return user;
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }
}
