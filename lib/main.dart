import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myproject/provider/favorite_provider.dart';
import 'package:provider/provider.dart';
import 'package:myproject/Screens/widgets/SplashScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
