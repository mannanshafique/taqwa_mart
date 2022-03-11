import 'dart:convert';

import 'package:get/get.dart';
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';

class B2BCartController extends GetxController {
  RxInt inc = 1.obs;
  RxBool isLoading = true.obs;
  RxDouble deliveryCharges = 0.0.obs;
  RxDouble freeDeliveryAfter = 0.0.obs;
  RxDouble minAmountForOrder = 0.0.obs;

  fetchDeliveryCharges() async {
    var deliveryChargesResponse =
        await B2BDeliveryCharges().getB2BdeliveryCharges();
    print('B2BDeliveryCharges response ${deliveryChargesResponse.statusCode}');
    //!
    var jsonData = jsonDecode(deliveryChargesResponse.body);
    if (deliveryChargesResponse.statusCode == 200) {
      deliveryCharges.value =
          double.parse(jsonData['data']['delievery_charges'].toString());
      freeDeliveryAfter.value = double.parse(
          jsonData['data']['free_delievery_charges_after'].toString());
      minAmountForOrder.value =
          double.parse(jsonData['data']['minimum_charges'].toString());
    }
  }

  @override
  void onInit() {
    fetchDeliveryCharges();
    super.onInit();
  }

  //!
  RxList<B2BCartModel> itemsList = <B2BCartModel>[].obs;

  RxDouble totalprice = 0.0.obs;

  void addProduct(B2BCartModel items) {
    int index = itemsList.indexWhere((i) => i.id == items.id);
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
    int index = itemsList.indexWhere((i) => i.id == product.id);
    itemsList[index].quantity = 1;
    itemsList.removeWhere((item) => item.id == product.id);
    calculateTotal();
    update();
  }

  void updateProduct(product, qty) {
    int index = itemsList.indexWhere((i) => i.id == product.id);
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

class B2BCartModel {
  int id;
  String? name;
  int? quantity;
  String? price;
  int? stock;
  bool isInCart;

  String imagePath;

  B2BCartModel(
      {this.name,
      this.quantity,
      this.price,
      required this.stock,
      required this.isInCart,
      required this.id,
      required this.imagePath});

  B2BCartModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        quantity = json['quantity'],
        price = json['price'],
        imagePath = json['imagePath'],
        isInCart = json['isInCart'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'imagePath': imagePath,
        'quantity': quantity,
        'price': price,
        'isInCart': isInCart,
      };
}
