import 'dart:convert';

import 'package:get/get.dart';
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  RxInt inc = 1.obs;
  RxBool isLoading = true.obs;
  RxBool isUserLogin = true.obs;
  // List<CartModel> cartList = [];
  RxDouble deliveryCharges = 0.0.obs;
  RxDouble freeDeliveryAfter = 0.0.obs;
  RxDouble minAmountForOrder = 0.0.obs;

  fetchDeliveryCharges() async {
    var deliveryChargesResponse =
        await DeliveryCharges().getdeliveryCharges();
    print('DeliveryCharges response ${deliveryChargesResponse.statusCode}');
    //!
    var jsonData = jsonDecode(deliveryChargesResponse.body);
    if (deliveryChargesResponse.statusCode == 200) {
      deliveryCharges.value =
          double.parse(jsonData['data']['delievery_charges'].toString());
      freeDeliveryAfter.value = double.parse(
          jsonData['data']['free_delievery_charges_after'].toString());
      minAmountForOrder.value = double.parse(
          jsonData['data']['minimum_charges'].toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchDeliveryCharges();
    fetchUserLogin();
  }

fetchUserLogin()async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("userEmail") == null) {
      isUserLogin.value  = false;
    } else {
      isUserLogin.value  = true;  
    }
}

  //!
  RxList<CartModel> itemsList = <CartModel>[].obs;

  RxDouble totalprice = 0.0.obs;

  void addProduct(CartModel items) {
    int index = itemsList.indexWhere((i) => i.name == items.name);
    print(index);
    if (index != -1)
      updateProduct(items, items.quantity! + 1);
    else {
      itemsList.add(items);
      calculateTotal();
      update();
      print('Add');
    }
  }

  void removeProduct(product) {
    int index = itemsList.indexWhere((i) => i.name == product.name);
    itemsList[index].quantity = 1;
    itemsList.removeWhere((item) => item.name == product.name);
    calculateTotal();
    update();
  }

  void updateProduct(product, qty) {
    int index = itemsList.indexWhere((i) => i.name == product.name);
    itemsList[index].quantity = qty;
    if (itemsList[index].quantity == 0) removeProduct(product);
    update();
    calculateTotal();
    itemsList.refresh();
  }

  void clearCart() {
    itemsList.forEach((f) => f.quantity = 1);
    itemsList.value = [];
    update();
  }

  void calculateTotal() {
    totalprice.value = 0.0;
    itemsList.forEach((f) {
      totalprice.value += int.parse(f.price!) * f.quantity!;
    });
    update();
  }
}

class CartModel {
  int id;
  String? name;
  int? quantity;
  String? price;
  int? stock;
  bool isInCart;
  
  String imagePath;

  CartModel(this.name, this.quantity, this.price,
      {required this.isInCart, required this.id,required this.imagePath,required this.stock,});

  CartModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        quantity = json['quantity'],
        price = json['price'],
        imagePath = json['imagePath'],
        isInCart = json['isInCart'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'imagePath':imagePath,
        'quantity': quantity,
        'price': price,
        'isInCart': isInCart,
      };
}
