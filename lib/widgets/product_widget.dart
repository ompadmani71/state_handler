import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_handler/models/product_model.dart';
import 'package:state_handler/view/detail_screen.dart';

InkWell productContainer(
    {required Size size,
    required Color primaryColor,
    required Dish product,
    required Function onTap,
    required int productIndex
    }) {
  return InkWell(
    onTap: (){
      Get.to(DetailScreen(productIndex: productIndex));
    },
    child: Container(
      // width: size.width * 0.43,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          // color: Colors.orange,
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
                      height: size.height * 0.1,
                      width: size.height * 0.1,
                      child: Image.asset(
                        product.image!,
                      )),
                ),
                Text(product.name!),
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
                  "\$ ${product.price}",
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
              borderRadius: BorderRadius.only(
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
              child: (product.isLike! == "True")
                  ? Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                    )
                  : Icon(
                      Icons.favorite_border,
                      color: Colors.grey,
                    ))
        ],
      ),
    ),
  );
}
