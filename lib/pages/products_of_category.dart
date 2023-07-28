import 'package:flutter/material.dart';

import '../model/product_model.dart';
import '../widgets/product_large.dart';

class ProductCategory extends StatefulWidget {
  List<Product> products;
  ProductCategory({Key? key, required this.products}) : super(key: key);

  @override
  State<ProductCategory> createState() => ProductCategoryState();
}

class ProductCategoryState extends State<ProductCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.products[0].category[0].toUpperCase() +
            widget.products[0].category.substring(1)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: widget.products
              .map((product) => LargeProductWidget(product: product))
              .toList(),
        ),
      ),
    );
  }
}
