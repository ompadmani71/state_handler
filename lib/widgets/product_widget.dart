import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_handler/controller/database_controller.dart';
import 'package:state_handler/models/product_model.dart';
import 'package:state_handler/view/detail_screen.dart';

InkWell productContainer(
    {required Size size,
    required Color primaryColor,
    required Function onTap,
    required int productIndex}) {
  DataBaseController dataBaseController = Get.find();

  Dish dish = dataBaseController.dishesData[productIndex];
  return InkWell(
    onTap: () {
      Get.to(DetailScreen(productIndex: dish.id!));
    },
    child: Container(
      // width: size.width * 0.43,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                      height: size.height * 0.15,
                      width: size.height * 0.1,
                      child: Image.asset(
                        dish.image!,
                      )),
                ),
                Text(dish.name!),
                Row(
                  children: [
                    Text(
                      "20 min",
                      style: TextStyle(fontSize: 10),
                    ),
                    Spacer(),
                    Icon(Icons.star, color: Colors.orangeAccent),
                    Text(
                      "4.5",
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "\$ ${dish.price}",
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              ),
              onTap: () {
                onTap();
              },
              child: Container(
                width: size.width * 0.13,
                height: size.width * 0.13,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    )),
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
          Positioned(
              right: 5,
              top: 5,
              child: Obx(() => (dataBaseController.dishesData[productIndex].isLike == "true")
                  ? IconButton(
                      onPressed: () async {
                        await dataBaseController.disLikeDish(id: dish.id!);
                      },
                      icon: const Icon(Icons.favorite, color: Colors.redAccent),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                    )
                  : IconButton(
                      onPressed: () async {
                        await dataBaseController.likeDish(id: dish.id!);
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.grey,
                      ),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              )))
        ],
      ),
    ),
  );
}
