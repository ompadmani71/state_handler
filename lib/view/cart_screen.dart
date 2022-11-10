import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:state_handler/controller/database_controller.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  DataBaseController dataBaseController = Get.find();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await dataBaseController.fetchCartData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                  child: Icon(Icons.shopping_cart_rounded, color: Colors.white70),
                ),
                Spacer(),
                Text(
                  "Cart",
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
            SizedBox(height: size.height * 0.02),
            Obx(() {
              if (dataBaseController.cartDishData.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: dataBaseController.cartDishData.length,
                      itemBuilder: (context, index){
                        return Container(
                          // height: 100,
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                    height: size.height * 0.1,
                                    width: size.height * 0.1,
                                    child: Image.asset(dataBaseController.cartDishData[index].image!)),
                              ),
                              SizedBox(width: size.width * 0.05),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(dataBaseController.cartDishData[index].name ?? "",style: TextStyle(fontSize: 17)),
                                  SizedBox(height: 5),
                                  Text("Price: \$${dataBaseController.cartDishData[index].price! * dataBaseController.cartDishData[index].quantity!}"),
                                  SizedBox(height: 5),
                                  Text("Qty: ${dataBaseController.cartDishData[index].quantity}"),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                        borderRadius: BorderRadius.circular(7),
                                        onTap: ()async{
                                          await dataBaseController.removeCart(dish: dataBaseController.cartDishData[index]);
                                        },
                                        child: Container(
                                          width: size.width * 0.08,
                                          height: size.width * 0.08,
                                          alignment: Alignment.center,
                                          child: Icon(Icons.delete_outlined, color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      InkWell(
                                        borderRadius: BorderRadius.circular(7),
                                        onTap: () async {
                                          await dataBaseController.removeQty(dish: dataBaseController.cartDishData[index]);
                                        },
                                        child: Container(
                                          width: size.width * 0.08,
                                          height: size.width * 0.08,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).primaryColor,
                                              borderRadius: BorderRadius.circular(7)),
                                          child: Icon(Icons.remove, color: Colors.white70),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text("${dataBaseController.cartDishData[index].quantity}"),
                                      SizedBox(width: 10),
                                      InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () async {
                                          await dataBaseController.addToCart(dish: dataBaseController.cartDishData[index]);
                                        },
                                        child: Container(
                                          width: size.width * 0.08,
                                          height: size.width * 0.08,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).primaryColor,
                                              borderRadius: BorderRadius.circular(7)),
                                          child: Icon(Icons.add, color: Colors.white70),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )


                            ],
                          )
                        );
                      })
                );
              } else {
                return const Expanded(
                    child: Center(child: Text("No added Cart")));
              }
            }),
            Obx(() => Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 5),
              decoration: DottedDecoration(
                shape: Shape.line,
                linePosition: LinePosition.top,
              ),
              child: Text("Total items: ${dataBaseController.totalCartItems.value}"),
            )),
            Obx(() => Text("Total price: \$${dataBaseController.totalCartPrice.value}")),
            SizedBox(height: size.height * 0.02)
          ],
        ),
      ),
    );
  }
}
