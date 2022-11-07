import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

      await dataBaseController.init();
      await dataBaseController.loadString(path: "assets/json/dishes.json");
      await dataBaseController.insertBulkRecord();
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
                  const Text("Search Food",
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 15,
                      )),
                  const Spacer(),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(Icons.filter_list_alt, color: Colors.white),
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
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Food",
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
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Fruits",
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
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Vegetables",
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
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Grocery",
                            style: TextStyle(
                                color:
                                    homeController.selectedCategory.value == 4
                                        ? Theme.of(context).primaryColor
                                        : Colors.black45),
                          ),
                        )),
                  ],
                )),
            Expanded(
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                  mainAxisExtent: size.height * 0.23
                ),
                itemBuilder: (context, index) {
                  return productContainer(
                      size: size,
                      primaryColor: Theme.of(context).primaryColor,
                      product: products[index],
                  productIndex: index,
                  onTap: (){
                        homeController.addCart(product: products[index]);
                        print("object ==> ${homeController.cartProducts.length}");
                  }
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
