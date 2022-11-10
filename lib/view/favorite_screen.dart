import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_handler/controller/database_controller.dart';

import '../models/product_model.dart';
import '../widgets/product_widget.dart';
import 'detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  DataBaseController dataBaseController = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await dataBaseController.fetchLikeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(Icons.favorite_border, color: Colors.white),
                ),
                Spacer(),
                Text(
                  "Favorite",
                  style: TextStyle(fontSize: 18),
                ),
                Spacer(),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ],
            ),
            Divider(),
            SizedBox(height: size.height * 0.05),
            Obx(() {
              if (dataBaseController.likeDishData.isNotEmpty) {
                return Expanded(
                  child: GridView.builder(
                    itemCount: dataBaseController.likeDishData.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 10,
                        mainAxisExtent: size.height * 0.28),
                    itemBuilder: (context, index) {
                      Dish dish = dataBaseController.likeDishData[index];

                      return InkWell(
                        onTap: () {
                          Get.to(DetailScreen(productIndex: dish.id!));
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
                                        Icon(Icons.star,
                                            color: Colors.orangeAccent),
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
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(25),
                                    topLeft: Radius.circular(25),
                                  ),
                                  onTap: () {},
                                  child: Container(
                                    width: size.width * 0.13,
                                    height: size.width * 0.13,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
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
                                  child:
                                  // Obx(() =>
                                  (dataBaseController.likeDishData[index].isLike == "true")
                                      ? IconButton(
                                          onPressed: () async {
                                            await dataBaseController
                                                .disLikeDish(id: dish.id!);
                                          },
                                          icon: const Icon(Icons.favorite,
                                              color: Colors.redAccent),
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
                                        ))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Expanded(
                    child: Center(child: Text("No added Favorite Dishes")));
              }
            })
          ],
        ),
      ),
    );
  }
}
