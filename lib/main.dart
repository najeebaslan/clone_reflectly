import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/splash_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black));
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reflectly Inspiration',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Google'),
      home: SplashScreen(),
    );
  }
}
