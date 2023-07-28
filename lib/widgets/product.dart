import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/pages/product_detail.dart';

import '../model/product_model.dart';

class ProductWidget extends StatefulWidget {
  final Product product;

  const ProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
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
      child: SizedBox(
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'productImage_${widget.product.id}',
                  child: Container(
                    width: 250,
                    height: 150,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.product.images[0],
                        fit: BoxFit.cover,
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
                Text(
                  formatProductTitle(widget.product.title, 17),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '\$ ${widget.product.price.toStringAsFixed(2)}\n',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.red,
                      decoration: TextDecoration.lineThrough,
                    ),
                    children: [
                      TextSpan(
                        text:
                            '\$ ${(widget.product.price - widget.product.price * widget.product.discountPercentage / 100).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color.fromARGB(255, 7, 55, 94),
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            widget.product.description.length > 60
                ? Text("${widget.product.description.substring(0, 60)}...")
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

  String formatProductTitle(String title, int totalCharacterLimit) {
    List<String> words = title.split(' ');
    List<String> formattedLines = [];
    int characterCount = 0;

    for (String word in words) {
      if (characterCount + word.length > totalCharacterLimit) {
        break;
      }

      formattedLines.add(word);
      characterCount += word.length + 1;
    }

    String formattedTitle = formattedLines.join(' ');

    if (formattedLines.length < words.length) {
      formattedTitle += '...';
    }

    return formattedTitle;
  }
}
