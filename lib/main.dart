import 'package:ecommerce_app/login_screen.dart';
import 'package:ecommerce_app/register_screen.dart';
import 'package:ecommerce_app/splash_screen.dart';
import 'package:ecommerce_app/viewproduct_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins',
      ),
      home:  SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}


