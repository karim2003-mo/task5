import 'package:flutter/material.dart';
import 'package:task5/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scrollBehavior: const MaterialScrollBehavior().copyWith(
    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
  ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme:  AppBarTheme(
          backgroundColor: Color.fromRGBO(94, 207, 202, 0.753),
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: Homepage(),
    );
  }
}