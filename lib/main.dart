import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginPage(),
      theme: ThemeData(
        listTileTheme: const ListTileThemeData(iconColor: Color(0xFF07375E)),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 7, 55, 94)),
        primaryColor: const Color.fromARGB(255, 7, 55, 94),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 7, 55, 94),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color.fromARGB(255, 7, 55, 94),
          unselectedItemColor: Color.fromARGB(255, 120, 159, 192),
          selectedLabelStyle: TextStyle(fontSize: 18.0),
          unselectedLabelStyle: TextStyle(fontSize: 16.00),
          selectedIconTheme: IconThemeData(size: 30),
          unselectedIconTheme: IconThemeData(size: 27),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
