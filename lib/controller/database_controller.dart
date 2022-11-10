import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:state_handler/controller/home_controller.dart';
import '../models/product_model.dart';

class DataBaseController extends GetxController {
  HomeController homeController = Get.find();

  Database? dbs;

  String tableName = "dishe";

  String column1_ID = "id";
  String column2_name = "name";
  String column3_category = "category";
  String column4_price = "price";
  String column5_quantity = "quantity";
  String column6_isLike = "isLike";
  String column7_image = "image";

  RxList<Dish> dishDecordedList = <Dish>[].obs;

  RxList<Dish> likeDishData = <Dish>[].obs;
  RxList<Dish> cartDishData = <Dish>[].obs;
  RxList<Dish> dishesData = <Dish>[].obs;

  RxInt totalCartItems = 0.obs;
  RxInt totalCartPrice = 0.obs;

  Future<void> loadString({required String path}) async {
    String productData =  await rootBundle.loadString(path);
    dishDecordedList.value = dishFromJson(productData);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoaded", true);

  }

  Future<Database?> init() async {
    String path = await getDatabasesPath();

    String dataBasePath = join(path, "product.db");

    dbs = await openDatabase(
      dataBasePath,
      version: 1,
      onCreate: (Database database, version) async {
        String query =
            "CREATE TABLE IF NOT EXISTS $tableName($column1_ID INTEGER PRIMARY KEY AUTOINCREMENT, $column2_name TEXT, $column3_category TEXT, $column4_price INTEGER, $column5_quantity INTEGER, $column6_isLike TEXT, $column7_image TEXT);";
        await database.execute(query);
      },
    );
    String query =
        "CREATE TABLE IF NOT EXISTS $tableName($column1_ID INTEGER PRIMARY KEY AUTOINCREMENT, $column2_name TEXT, $column3_category TEXT, $column4_price INTEGER, $column5_quantity INTEGER, $column6_isLike TEXT, $column7_image TEXT);";
    dbs!.execute(query);
    return dbs;
  }

  Future insertBulkRecord() async {
    deleteTable();
    dbs = await init();

    for (var i = 0; i < dishDecordedList.length; i++) {
      Dish dish = dishDecordedList[i];

      String sql =
          "INSERT INTO $tableName VALUES(?,?,?,?,?,?,?);";
      List arg = [
        null,
        dish.name,
        dish.category,
        dish.price,
        dish.quantity,
        dish.isLike,
        dish.image,
      ];
      int id = await dbs!.rawInsert(sql,arg);
      print("object jidbhvdcbjsk ==> $id");
    }
  }

  Future deleteTable() async {
    dbs = await init();
    String sql = "DROP TABLE $tableName";
    await dbs!.execute(sql);
  }

  Future<void> fetchData({String? search}) async {
    dbs = await init();

    String condition = "";

    switch(homeController.selectedCategory.value){
      case 2:
        condition = "Food";
        break;

      case 3:
        condition = "Fruit";
        break;

      case 4:
        condition = "Vegetable";
        break;

      case 5:
        condition = "Grocery";
        break;

      case 6:
        condition = "%$search%";
    }

    String sql = "";

    if(condition.isEmpty){
      sql = "SELECT *FROM $tableName;";
    } else {
     sql = "SELECT *FROM $tableName WHERE $column3_category = '${condition}';";
    }

    List<Map<String, dynamic>> data = await dbs!.rawQuery(sql);
    dishesData.value = dishFromJson(jsonEncode(data));
    print("object ==> ${dishesData[0].quantity}");
  }

  Future<void> fetchLikeData() async {
    dbs = await init();

     String sql = "SELECT *FROM $tableName WHERE $column6_isLike = 'true';";
     List<Map<String, dynamic>> data = await dbs!.rawQuery(sql);
     likeDishData.value = dishFromJson(jsonEncode(data));
  }

  Future<void> fetchCartData() async {
    dbs = await init();

     String sql = "SELECT *FROM $tableName WHERE $column5_quantity > 0;";
     List<Map<String, dynamic>> data = await dbs!.rawQuery(sql);
    cartDishData.value = dishFromJson(jsonEncode(data));

    for(Dish dish in cartDishData){
      totalCartItems.value = totalCartItems.value + dish.quantity!;
    }

    for(Dish dish in cartDishData){
      totalCartPrice.value = totalCartPrice.value + (dish.quantity! * dish.price!);
    }

  }

  Future<void> likeDish({ required int id}) async {
    dbs = await init();

    String sql = "UPDATE $tableName SET $column6_isLike = 'true' WHERE $column1_ID = $id";
    await dbs!.rawUpdate(sql);
    await fetchData();
    await fetchLikeData();
  }

  Future<void> disLikeDish({ required int id}) async {
    dbs = await init();

    String sql = "UPDATE $tableName SET $column6_isLike = 'false' WHERE $column1_ID = $id";
    await dbs!.rawUpdate(sql);
    await fetchData();
    await fetchLikeData();
  }


Future<void> addToCart({required Dish dish}) async {
  dbs = await init();

  int? quantity;
  if(dish.quantity! >= 0){
  quantity = dish.quantity! + 1;
  }

  String query = "UPDATE  $tableName SET $column5_quantity = ${quantity ?? 0} WHERE $column1_ID = ${dish.id};";
  await dbs!.rawUpdate(query);
  //
  // String selectQuery = "SELECT *FROM $tableName WHERE $column1_ID = ${dish.id};";
  // List<Map<String, dynamic>> data = await dbs!.rawQuery(selectQuery);
  print("wkodjibhj ==> $quantity");
  await fetchData();
await fetchCartData();
}

Future<void> removeQty({required Dish dish}) async {
  dbs = await init();

  int? quantity;
  if(dish.quantity! > 1){
  quantity = dish.quantity! - 1;
  String query = "UPDATE  $tableName SET $column5_quantity = ${quantity ?? 0} WHERE $column1_ID = ${dish.id};";
  await dbs!.rawUpdate(query);
  await fetchData();
  await fetchCartData();
  }
}

Future<void> removeCart({required Dish dish}) async {
  dbs = await init();

  String query = "UPDATE  $tableName SET $column5_quantity = 0 WHERE $column1_ID = ${dish.id};";
  await dbs!.rawUpdate(query);
  await fetchData();
  await fetchCartData();
}

}
