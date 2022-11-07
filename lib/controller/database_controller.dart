import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class DataBaseController extends GetxController {
  Database? dbs;

  String tableName = "dishe";

  String column1_ID = "id";
  String column2_name = "name";
  String column3_category = "category";
  String column4_price = "price";
  String column5_quantity = "quantity";
  String column6_isLike = "isLike";
  String column7_image = "image";

  RxList<String> images = <String>[].obs;

  RxList<Dish> dishDecordedList = <Dish>[].obs;
  RxList<Dish> dishesData = <Dish>[].obs;

  Future<void> loadString({required String path}) async {
    String productData =  await rootBundle.loadString(path);
    dishDecordedList.value = dishFromJson(productData);
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

    for (Dish product in dishDecordedList) {
      String image = await getImagesBytes(url: product.image ?? "");
      images.add(image);
    }

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
        images[i].toString(),
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

  Future<void> fetchData() async {
    dbs = await init();
    // String sql = "SELECT $column1_ID, $column2_name, $column3_category, $column4_price, $column5_quantity, $column6_isLike FROM $tableName;";
    String sql = "SELECT *FROM $tableName;";

    List<Map<String, dynamic>> data = await dbs!.rawQuery(sql);
    dishesData.value = dishFromJson(jsonEncode(data));

    // dishesData.value = data.forEach((element) {
    //   Dish.fromJson(element);
    // });

    // for(var value in data){
    //   Dish dish = Dish.fromJson(value);
    //   dishesData.add(dish);
    // }
    print("object ==> ${dishesData[0].category}");
  }


  Future<String> getImagesBytes({required String url}) async {

    ByteData bytes = await rootBundle.load(url);
    ByteBuffer byteBuffer = bytes.buffer;
    return base64Encode(Uint8List.view(byteBuffer));
  }

//
// Future<void> addToCart({required Product product, required int index}) async {
//   dbs = await init();
//
//   int? quantity;
//   if(product.quantity! > 0){
//   quantity = product.quantity! - 1;
//   }
//
//   String query = "UPDATE  $tableName SET $column4_quantity = ${quantity ?? 0} WHERE $column1_ID = ${product.id};";
//   dbs!.rawUpdate(query);
//
//   String selectQuery = "SELECT *FROM $tableName WHERE $column1_ID = ${product.id};";
//   List<Map<String, dynamic>> data = await dbs!.rawQuery(selectQuery);
//   List<Product> recoverProduct = productFromJson(jsonEncode(data));
//
//   productFetchData[index] =  recoverProduct[0];
// }

}
