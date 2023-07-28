import 'package:dio/dio.dart';
import 'package:flutter_ecommerce/constant/api_url.dart';
import 'package:flutter_ecommerce/model/cart_model.dart';

class CartService {
  final String url = "$apiUrl/carts";
  Dio dio = Dio();

  Future<CartModel?> getCartsOfUser(int id) async {
    try {
      final response = await dio.get<String>("$url/user/$id");
      if (response.statusCode == 200) {
        var carts = cartModelFromJson(response.data!);
        return carts;
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }
}
