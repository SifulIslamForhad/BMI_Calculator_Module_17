import 'package:flutter/material.dart';

import 'MyHomePage.dart';





void main() {
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          titleMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.normal, color: Colors.black),
          titleSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        )
      ),

    );
  }
}



