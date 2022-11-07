import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:state_handler/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:state_handler/view/cart_screen.dart';
import 'package:state_handler/view/favorite_screen.dart';
import 'package:state_handler/view/home_screen.dart';
import 'package:state_handler/view/message_screen.dart';
import 'package:state_handler/view/notification_screen.dart';
import 'package:state_handler/widgets/product_widget.dart';

import 'detail_screen.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({Key? key}) : super(key: key);

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          homeController.navigationSelected(4);
        },
        child: Icon(Icons.shopping_cart_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(() => AnimatedBottomNavigationBar(
          icons: const [
            Icons.home,
            Icons.message_outlined,
            Icons.notifications,
            Icons.favorite_border,
          ],
          activeColor: Theme.of(context).primaryColor,
          activeIndex: homeController.navigationSelected.value,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
          onTap: (value){
            homeController.navigationSelected(value);
          }

      ),),
      body: Obx(() => (homeController.navigationSelected.value == 0)
          ? const HomeScreen()
          : (homeController.navigationSelected.value == 1)
            ? const MessageScreen()
            : (homeController.navigationSelected.value == 2)
              ? const NotificationScreen()
              : (homeController.navigationSelected.value == 3)
                ? const FavoriteScreen()
                : (homeController.navigationSelected.value == 4)
                    ? const CartScreen()
                    : Container()
      )
    );
  }
}
