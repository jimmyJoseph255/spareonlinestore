import 'package:flutter/material.dart';
import 'package:myproject/Screens/Dashboard.dart';

List<Map<String, String>> cartItems = [];

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: "Hello",
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: Start());
  }
}
