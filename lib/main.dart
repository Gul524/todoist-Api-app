import 'package:flutter/material.dart';
import 'package:practice/pages.dart/createPage.dart';
import 'package:practice/pages.dart/homepage.dart';
import 'package:practice/post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}
