import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/pages/comments.dart';
import 'package:flutter_ecommerce/service/post_service.dart';
import 'package:flutter_ecommerce/service/user_service.dart';
import 'dart:ui' as ui;
import '../../model/post_model.dart';
import '../../model/user_model.dart';
import '../../widgets/post_card.dart';

class SocialPage extends StatefulWidget {
  User user;
  SocialPage({Key? key, required this.user}) : super(key: key);

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage>
    with SingleTickerProviderStateMixin {
  final PostService _postService = PostService();
  final UserService _userService = UserService();
  String _searchQuery = '';
  List<Post> _searchResults = [];

  List<Post> allPosts = [];
  List<Post> myPosts = [];
  List<User> users = [];

  bool isLoaded = false;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadPosts();
  }

  void _loadPosts() async {
    var postsResponse = await _postService.getAllPosts();
    var usersResponse = await _userService.getAllUsers();
    var myPostsResponse = await _postService.getMyPosts(widget.user.id);

    setState(() {
      if (postsResponse != null &&
          usersResponse != null &&
          myPostsResponse != null) {
        allPosts = postsResponse.posts;
        myPosts = myPostsResponse.posts;

        users = usersResponse.users;
        isLoaded = true;
      } else {
        debugPrint("Failed to load posts or users");
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  void _loadSearchedData(String query) {
    _postService.searchPosts(query).then((value) {
      setState(() {
        _searchResults = value!;
        _tabController.animateTo(2);
      });
      debugPrint(_searchResults.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Social"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Search'),
                  content: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter search query',
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _loadSearchedData(_searchQuery);
                      },
                      child: const Text('Search'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'All Posts'),
            Tab(text: 'My Posts'),
            Tab(text: 'Search Results'),
          ],
        ),
      ),
      body: isLoaded
          ? TabBarView(
              controller: _tabController,
              children: [
                _buildPostListView(allPosts),
                _buildPostListView(myPosts),
                _buildPostListView(_searchResults),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(
                color: ui.Color.fromARGB(255, 7, 55, 94),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
        ),
        backgroundColor: ui.Color.fromARGB(255, 7, 55, 94),
      ),
    );
  }

  Widget _buildPostListView(List<Post> posts) {
    return posts.isNotEmpty
        ? ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              var post = posts[index];
              return GestureDetector(
                onTap: () => _openPostCommentsPage(post),
                child: PostCardWidget(
                  post: post,
                  user: users.firstWhere(
                    (user) => user.id == post.userId,
                  ),
                ),
              );
            },
          )
        : Center(
            child: Text("Nothing to display :/"),
          );
  }

  void _openPostCommentsPage(Post post) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return PostCommentsPage(
          index: post.id,
          userId: widget.user.id,
        );
      }),
    );
  }
}
