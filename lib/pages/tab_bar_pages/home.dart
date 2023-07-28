import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/constant/categories.dart';
import 'package:flutter_ecommerce/model/product_model.dart';
import 'package:flutter_ecommerce/pages/products_of_category.dart';
import 'package:flutter_ecommerce/service/product_service.dart';

import '../../model/user_model.dart';
import '../../widgets/product.dart';

class HomePage extends StatefulWidget {
  User user;
  HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductService _productService = ProductService();
  final Map<String, List<Product>> _productMap = {};

  @override
  void initState() {
    super.initState();
    for (var category in categories) {
      _loadProducts(category);
    }
  }

  void _loadProducts(String category) {
    _productService.getProductsOfCategory(category).then((value) {
      if (value != null && value.products != null) {
        setState(() {
          _productMap[category] = value.products;
          debugPrint('${_productMap[category]!.length} $category');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, ${widget.user.firstName}!"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Categories",
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (var category in categories) Category(category),
                      ])),
              SizedBox(
                height: 10,
              ),
              for (var category in _productMap.keys)
                _buildProductColumn(category, _productMap[category]!),
            ],
          ),
        ),
      ),
    );
  }

  Padding Category(String category) {
    final products = _productMap[category];
    if (products != null && products.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return ProductCategory(products: products);
            }));
          },
          child: Container(
            height: 200,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(_productMap["${category}"]![0].images[0]),
                fit: BoxFit.fill,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.1, sigmaY: 0.1),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    category.toString()[0].toUpperCase() +
                        category.toString().substring(1),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Padding(padding: EdgeInsets.all(0));
    }
  }

  Column _buildProductColumn(String category, List<Product> products) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              category[0].toUpperCase() + category.substring(1),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ProductCategory(products: products);
                }));
              },
              child: const Text(
                "SEE ALL",
                style: TextStyle(),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (var product in products)
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ProductWidget(product: product),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
