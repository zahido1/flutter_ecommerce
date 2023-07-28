import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/product_model.dart' as product;
import 'package:flutter_ecommerce/pages/product_detail.dart';
import 'package:flutter_ecommerce/service/cart_service.dart';
import 'package:flutter_ecommerce/service/product_service.dart';
import 'dart:ui' as ui;
import '../../model/cart_model.dart';
import '../../model/user_model.dart';

class CartPage extends StatefulWidget {
  User user;
  CartPage({Key? key, required this.user}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final ProductService _productService = ProductService();
  product.Product? selectedProduct;
  final CartService _cartService = CartService();
  Cart? cart;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  void _loadCart() {
    _cartService.getCartsOfUser(widget.user.id).then((value) {
      setState(() {
        if (value != null && value.carts.isNotEmpty) {
          cart = value.carts[0];
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: cart != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cart!.products.length,
                  itemBuilder: (context, productIndex) {
                    var product = cart!.products[productIndex];
                    return Dismissible(
                      key: Key(product.id.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        color: Colors.red,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          cart!.products.removeAt(productIndex);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text("Item removed from cart"),
                            action: SnackBarAction(
                              label: "UNDO",
                              onPressed: () {
                                setState(() {
                                  cart!.products.insert(productIndex, product);
                                });
                              },
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: const Icon(Icons.shopping_cart),
                        title: Text(product.title),
                        subtitle: Text("Price: \$${product.price.toString()}"),
                        onTap: () async {
                          selectedProduct =
                              await _productService.getProduct(product.id);
                          if (selectedProduct != null) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return ProductDetailPage(
                                      product: selectedProduct!);
                                },
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                      backgroundColor: ui.Color.fromARGB(255, 7, 55, 94),
                    ),
                    child: const Text(
                      'Purchase Now',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(
                color: ui.Color.fromARGB(255, 7, 55, 94),
              ),
            ),
    );
  }
}
