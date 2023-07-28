import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/pages/tab_bar_pages/social.dart';
import 'package:flutter_ecommerce/service/user_service.dart';
import '../pages/tab_bar_pages/cart.dart';
import '../pages/tab_bar_pages/home.dart';
import '../pages/tab_bar_pages/profile.dart';
import '../pages/tab_bar_pages/search.dart';
import '../model/user_model.dart';

class TabBarWidget extends StatefulWidget {
  final int userId;
  const TabBarWidget({Key? key, required this.userId}) : super(key: key);

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  late User user;
  final UserService _userService = UserService();
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() {
    _userService.getUser(widget.userId).then((value) {
      if (value != null) {
        setState(() {
          user = value;
          pages = [
            HomePage(user: user),
            const SearchPage(),
            CartPage(user: user),
            SocialPage(user: user),
            ProfilePage(user: user),
          ];
        });
      }
    });
  }

  int _item = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_grocery_store), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Social"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: _item,
        onTap: (value) => {
          setState(() {
            _item = value;
          }),
        },
      ),
      body: pages.isNotEmpty ? pages[_item] : Container(),
    );
  }
}
