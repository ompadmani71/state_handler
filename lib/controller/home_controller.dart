import 'package:get/get.dart';

import '../models/product_model.dart';

class HomeController extends GetxController {
  RxInt selectedCategory = 1.obs;

  RxInt navigationSelected = 0.obs;

  Set<Dish> cartProducts = {};


  void addCart({required Dish product}){
    cartProducts.add(product);
    update();
  }
}
