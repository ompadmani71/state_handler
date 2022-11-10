import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_handler/controller/database_controller.dart';
import 'package:state_handler/controller/home_controller.dart';
import 'package:state_handler/models/product_model.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.productIndex}) : super(key: key);

  final int productIndex;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DataBaseController dataBaseController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Dish dish = dataBaseController.dishesData[widget.productIndex];

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              Container(
                height: size.height,
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.06,
                    vertical: size.height * 0.06),
                alignment: Alignment.topCenter,
                color: Theme.of(context).primaryColor,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white30),
                        child: Icon(
                          Icons.arrow_back_ios_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Food Details",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    const Spacer(),
                    Container(
                      height: size.width * 0.1,
                      width: size.width * 0.1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white30),
                      child: Obx(() => (dataBaseController
                                  .dishesData[widget.productIndex].isLike ==
                              "true")
                          ? IconButton(
                              onPressed: () async {
                                await dataBaseController.disLikeDish(
                                    id: dish.id!);
                              },
                              icon: const Icon(Icons.favorite,
                                  color: Colors.redAccent),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            )
                          : IconButton(
                              onPressed: () async {
                                await dataBaseController.likeDish(
                                    id: dish.id!);
                              },
                              icon: const Icon(
                                Icons.favorite_border,
                                color: Colors.grey,
                              ),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            )),
                    ),
                  ],
                ), //Container
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: size.height * 0.65,
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(40)),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * 0.17,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${dish.name}",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "\$ ${dish.price}",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                              height: size.height * 0.07,
                              width: size.width * 0.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Theme.of(context).primaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 0.5,
                                        blurRadius: 2,
                                        offset: Offset(0, 3))
                                  ]),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          // product
                                        },
                                        icon: Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        )),
                                    // Obx(
                                    //   () =>
                                    Text(
                                      "${dish.quantity}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                ),
                                Text(
                                  "4.5",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.water_drop,
                                  color: Colors.red,
                                ),
                                Text(
                                  "100 Kcal",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.watch_later_sharp,
                                  color: Colors.orangeAccent,
                                ),
                                Text(
                                  "4.5",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text("About food",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. ",
                            style: TextStyle(fontSize: 13, color: Colors.grey)),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            // Navigator.pushNamed(context,"/");
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.025),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 0.5,
                                      blurRadius: 2,
                                      offset: Offset(0, 3))
                                ]),
                            child: Text(
                              "Add to cart",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ), //Container
              Positioned(
                left: size.width * 0.20,
                top: size.height * 0.2,
                child: Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("${dish.image}"),
                          fit: BoxFit.cover)),
                ),
              ),
            ], //<Widget>[]
          ), //Center
        ));
  }
}
