import 'package:flutter/material.dart';
import 'home_page.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'nima',
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}