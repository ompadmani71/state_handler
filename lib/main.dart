import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_handler/controller/database_controller.dart';
import 'package:state_handler/controller/home_controller.dart';
import 'package:state_handler/view/navigation_bar.dart';
import 'package:state_handler/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  HomeController homeController = Get.put(HomeController());
  DataBaseController dataBaseController = Get.put(DataBaseController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xff4aa433, <int, Color>{
          50: Color(0xff4aa433),
          100: Color(0xff4aa433),
          200: Color(0xff4aa433),
          300: Color(0xff4aa433),
          400: Color(0xff4aa433),
          500: Color(0xff4aa433),
          600: Color(0xff4aa433),
          700: Color(0xff4aa433),
          800: Color(0xff4aa433),
          900: Color(0xff4aa433),
        })
      ),
      home: const SplashScreen(),
    );
  }
}
