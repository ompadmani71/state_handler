import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_handler/controller/database_controller.dart';
import 'package:state_handler/controller/home_controller.dart';

import '../models/product_model.dart';
import '../widgets/product_widget.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.find();
  DataBaseController dataBaseController = Get.find();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      bool isLoaded = prefs.getBool('isLoaded') ?? false;

      await dataBaseController.init();
      if (isLoaded == false) {
        await dataBaseController.loadString(path: "assets/json/dishes.json");
        await dataBaseController.insertBulkRecord();
      }
      await dataBaseController.fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(Icons.menu, color: Colors.white),
                ),
                const Spacer(),
                Icon(Icons.location_pin, color: Theme.of(context).primaryColor),
                const Text(" Magura, BD",
                    style: TextStyle(color: Colors.black54)),
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://d1vwxdpzbgdqj.cloudfront.net/assets/professional-courses/professional-banner-e0c1ba5a4c2d6b53708b17d8c1fc6b79d59e7328e42f6490832acf7511c2a3e3.jpg"),
                          fit: BoxFit.cover)),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Hi Rinku",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 5),
            Text(
              "Find your food",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor.withOpacity(0.1)),
              child: Row(
                children: [
                  Icon(Icons.search, color: Theme.of(context).primaryColor),
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(10,0,0,0),
                        hintText: "Search here",
                        // suffix: InkWell(
                        //   splashColor: Colors.transparent,
                        //   highlightColor: Colors.transparent,
                        //   onTap: () {},
                        //   child: const Icon(Icons.clear,color: Colors.grey),
                        // ),
                    ),
                    onChanged: (value) {
                      homeController.selectedCategory(6);
                      dataBaseController.fetchData(search: value);
                    },
                  )),
                  // const Spacer(),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child:
                        const Icon(Icons.filter_list_alt, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Obx(() => Row(
                  children: [
                    InkWell(
                        highlightColor: Colors.white,
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          homeController.selectedCategory.value = 1;
                          dataBaseController.fetchData();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "All",
                            style: TextStyle(
                                color:
                                    homeController.selectedCategory.value == 1
                                        ? Theme.of(context).primaryColor
                                        : Colors.black45),
                          ),
                        )),
                    InkWell(
                        highlightColor: Colors.white,
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          homeController.selectedCategory.value = 2;
                          dataBaseController.fetchData();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Food",
                            style: TextStyle(
                                color:
                                    homeController.selectedCategory.value == 2
                                        ? Theme.of(context).primaryColor
                                        : Colors.black45),
                          ),
                        )),
                    InkWell(
                        highlightColor: Colors.white,
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          homeController.selectedCategory.value = 3;
                          dataBaseController.fetchData();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Fruits",
                            style: TextStyle(
                                color:
                                    homeController.selectedCategory.value == 3
                                        ? Theme.of(context).primaryColor
                                        : Colors.black45),
                          ),
                        )),
                    InkWell(
                        highlightColor: Colors.white,
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          homeController.selectedCategory.value = 4;
                          dataBaseController.fetchData();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Vegetables",
                            style: TextStyle(
                                color:
                                    homeController.selectedCategory.value == 4
                                        ? Theme.of(context).primaryColor
                                        : Colors.black45),
                          ),
                        )),
                    InkWell(
                        highlightColor: Colors.white,
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          homeController.selectedCategory.value = 5;
                          dataBaseController.fetchData();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Grocery",
                            style: TextStyle(
                                color:
                                    homeController.selectedCategory.value == 5
                                        ? Theme.of(context).primaryColor
                                        : Colors.black45),
                          ),
                        )),
                  ],
                )),
            SizedBox(height: 20),
            Obx(() {
              if (dataBaseController.dishesData.isNotEmpty) {
                return Expanded(
                  child: GridView.builder(
                    itemCount: dataBaseController.dishesData.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 10,
                        mainAxisExtent: size.height * 0.28),
                    itemBuilder: (context, index) {
                      return productContainer(
                          size: size,
                          primaryColor: Theme.of(context).primaryColor,
                          productIndex: index,
                          onTap: () {
                            dataBaseController.addToCart(
                                dish: dataBaseController.dishesData[index]);
                          });
                    },
                  ),
                );
              } else {
                return const Expanded(
                    child: Center(child: CircularProgressIndicator()));
              }
            })
          ],
        ),
      ),
    );
  }
}
