import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/pages/about_me.dart';
import 'package:flutter_ecommerce/pages/login.dart';
import 'package:flutter_ecommerce/pages/order_history.dart';
import 'package:flutter_ecommerce/pages/settings.dart';
import '../../model/user_model.dart';
import 'dart:ui' as ui;

class ProfilePage extends StatefulWidget {
  final User user;

  ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.user.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text('Options',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ui.Color.fromARGB(255, 7, 55, 94),
                      )),
                  const SizedBox(height: 8),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text(
                      'About Me',
                      style: TextStyle(
                        color: ui.Color.fromARGB(255, 7, 55, 94),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return AboutMePage(
                          user: widget.user,
                        );
                      }));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_cart),
                    title: const Text(
                      'Order History',
                      style: TextStyle(
                        color: ui.Color.fromARGB(255, 7, 55, 94),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const OrderHistoryPage();
                      }));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text(
                      'Settings',
                      style: TextStyle(
                        color: ui.Color.fromARGB(255, 7, 55, 94),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const SettingsPage();
                      }));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        color: ui.Color.fromARGB(255, 7, 55, 94),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      }));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
