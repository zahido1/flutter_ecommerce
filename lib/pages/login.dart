import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/widgets/tab_bar.dart';

import '../service/user_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool login = true;
  final UserService _userService = UserService();
  final TextEditingController _usernameController =
      TextEditingController(text: "kminchelle");
  final TextEditingController _passwordController =
      TextEditingController(text: "0lelplR");

  void _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      return;
    }

    final userId = await _userService.loginMethod(username, password);
    if (userId != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TabBarWidget(userId: userId)),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Failed'),
          content: const Text('Invalid username or password.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/img_1.jpg",
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 150),
                    const Text(
                      "My Store",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "It's modular and designed to last",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                login
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            TextField(
                              controller: _usernameController,
                              decoration: const InputDecoration(
                                hintText: 'Username',
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _login,
                              child: const Text('Login'),
                            ),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    login = false;
                                  });
                                },
                                child: const Text(
                                    "Don't have an account? Sign up now!")),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const TextField(
                              decoration: InputDecoration(
                                hintText: 'Email',
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Signup'),
                            ),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    login = true;
                                  });
                                },
                                child: const Text(
                                    "Already have an account? Login now!")),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
