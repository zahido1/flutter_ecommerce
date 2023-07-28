import 'package:dio/dio.dart';
import 'package:flutter_ecommerce/constant/api_url.dart';
import 'package:flutter_ecommerce/model/product_model.dart';

class ProductService {
  final String url = "$apiUrl/products";
  Dio dio = Dio();

  Future<ProductModel?> getProducts() async {
    try {
      final response = await dio.get<String>(url);
      if (response.statusCode == 200) {
        var products = productModelFromJson(response.data!);
        return products;
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }

  Future<Product?> getProduct(var id) async {
    try {
      final response = await dio.get("$url/$id");
      if (response.statusCode == 200) {
        var product = Product.fromJson(response.data);
        print("Success");
        return product;
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }

  // Future addProduct(
  //     var id,
  //     var title,
  //     var description,
  //     var price,
  //     var discountPercentage,
  //     var rating,
  //     var stock,
  //     var brand,
  //     var category,
  //     var thumbnail,
  //     var images) async {
  //   try {
  //     ProductModel product = ProductModel(
  //         id: id,
  //         title: title,
  //         description: description,
  //         price: price,
  //         discountPercentage: discountPercentage,
  //         rating: rating,
  //         stock: stock,
  //         brand: brand,
  //         category: category,
  //         thumbnail: thumbnail,
  //         images: images);
  //     final request = await dio.post("$url/add", data: product.toJson());
  //     if (request.statusCode == 201) {
  //       debugPrint("Post added!");
  //     }
  //   } catch (e) {
  //     debugPrint("Something went wrrong!");
  //     throw Exception(e);
  //   }
  // }

  Future<List<Product>?> searchProducts(String query) async {
    String searchProduct = "$apiUrl/products/search?q=$query";
    try {
      final response = await dio.get<String>(searchProduct);
      if (response.statusCode == 200) {
        var products = productModelFromJson(response.data!);
        return products.products;
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }

  Future<ProductModel?> getProductsOfCategory(String category) async {
    String categoryUrl = "$apiUrl/products/category/$category";
    try {
      final response = await dio.get<String>(categoryUrl);
      if (response.statusCode == 200) {
        var products = productModelFromJson(response.data!);
        return products;
      }
    } catch (e) {
      throw Exception();
    }
    return null;
  }
}
