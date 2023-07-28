import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/post_model.dart';

import '../model/user_model.dart';

class PostCardWidget extends StatefulWidget {
  Post post;
  User user;
  PostCardWidget({Key? key, required this.post, required this.user})
      : super(key: key);

  @override
  State<PostCardWidget> createState() => _PostCardWidgetState();
}

class _PostCardWidgetState extends State<PostCardWidget> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Post by',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
                Builder(builder: (context) {
                  return Row(
                    children: [
                      CircleAvatar(
                        radius: 12.0,
                        backgroundImage: NetworkImage(widget.user.image),
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        '@${widget.user.username}',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              widget.post.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              widget.post.body,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    InkWell(
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
                    const SizedBox(width: 4.0),
                    isFavorite == true
                        ? Text(
                            (widget.post.reactions + 1).toString(),
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            widget.post.reactions.toString(),
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                  ],
                ),
                const Text(
                  'Tap to view comments',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
