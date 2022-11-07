import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_handler/view/navigation_bar.dart';
import '../view/navigation_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: size.height * 0.12),
            Image.asset("assets/images/foodDish.png",scale: 4),
            SizedBox(height: size.height * 0.02),
            const Text("Fast delivery at \n your doorstep",style: TextStyle(color: Colors.white,fontSize: 20)),
            SizedBox(height: size.height * 0.02),
            Text("Home delivery and online reservation system for restaurants & cafe",textAlign: TextAlign.center,style: TextStyle(color: Colors.white12.withOpacity(0.9),fontSize: 15)),
            const Spacer(),
            InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: (){
                Get.to(const NavigationBarPage());
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      spreadRadius: 2
                    )
                  ]
                ),
                child: Text("Let's Explore",style: TextStyle(color: Theme.of(context).primaryColor),),
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
