import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/service/post_service.dart';

import '../model/comment_model.dart';

class PostCommentsPage extends StatefulWidget {
  final int index;
  final int userId;

  const PostCommentsPage({Key? key, required this.index, required this.userId})
      : super(key: key);

  @override
  State<PostCommentsPage> createState() => _PostCommentsPageState();
}

class _PostCommentsPageState extends State<PostCommentsPage> {
  final TextEditingController _commentController = TextEditingController();

  final PostService _postService = PostService();

  List<Comment> postComments = [];

  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  void _loadComments() {
    _postService.getPostComments(widget.index).then((value) {
      setState(() {
        isLoaded = true;
        if (value != null) {
          postComments = value.comments;
        }
      });
    });
  }

  void _addComment(String text, int postId, int userId) {
    _postService.addComment(text, postId, userId).then((newComment) {
      if (newComment != null) {
        setState(() {
          postComments.add(newComment);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        centerTitle: true,
      ),
      body: isLoaded
          ? (postComments.isNotEmpty
              ? ListView.separated(
                  itemCount: postComments.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    Comment comment = postComments[index];

                    return ListTile(
                      title: Text(comment.user.username),
                      subtitle: Text(comment.body),
                    );
                  },
                )
              : const Center(
                  child: Text("No comments yet"),
                ))
          : const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 7, 55, 94),
              ),
            ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _commentController,
                decoration: const InputDecoration(
                  hintText: 'Enter a comment',
                ),
                onFieldSubmitted: (value) {
                  _addComment(value, widget.index, widget.userId);
                },
              ),
            ),
            IconButton(
              onPressed: () {
                final commentText = _commentController.text;
                if (commentText.isNotEmpty) {
                  _addComment(commentText, widget.index, widget.userId);
                  _commentController.clear();
                }
              },
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
