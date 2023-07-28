import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/product_model.dart';

import '../pages/product_detail.dart';

class LargeProductWidget extends StatefulWidget {
  final Product product;
  const LargeProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  State<LargeProductWidget> createState() => _LargeProductWidgetState();
}

class _LargeProductWidgetState extends State<LargeProductWidget> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ProductDetailPage(product: widget.product);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Center(
                    child: Hero(
                      tag: 'productImage_${widget.product.id}',
                      child: Container(
                        height: 250,
                        width: 350,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            widget.product.images[0],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: toggleFavorite,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: isFavorite
                            ? const Icon(
                                Icons.favorite,
                                key: Key('favorite'),
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                key: Key('unfavorite'),
                                color: Colors.red,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.product.title.length > 22
                      ? Text(
                          "${widget.product.title.substring(0, 22)}...",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      : Text(
                          widget.product.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                  Text(
                    '\$ ${(widget.product.price - widget.product.price * widget.product.discountPercentage / 100).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromARGB(255, 7, 55, 94),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              widget.product.description.length > 100
                  ? Text("${widget.product.description.substring(0, 100)}...")
                  : Text(widget.product.description),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Reviews ',
                          style: const TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: '(${widget.product.rating.toString()})',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      starIcon(),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Added to the cart sucessfully")));
                    },
                    icon: const Icon(
                      Icons.add_circle_rounded,
                      color: Color.fromARGB(255, 7, 55, 94),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row starIcon() {
    int roundedReview = widget.product.rating.round();

    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      if (i < roundedReview) {
        stars.add(
          const Icon(
            Icons.star,
            size: 18,
            color: Colors.amber,
          ),
        );
      } else {
        stars.add(
          const Icon(
            Icons.star,
            size: 18,
            color: Colors.grey,
          ),
        );
      }
    }

    return Row(
      children: stars,
    );
  }
}
