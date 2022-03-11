import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Constant/Widgets/popUp.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Authentication/Login_Screen/login_screen.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Checkout/checkout_screen.dart';

import 'Cart_Controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  final cartContoller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //! -------------Appbar
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'My Cart',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          actions: [
            Obx(() => Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '${cartContoller.itemsList.length.toString()} Items',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: blackColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ))
          ],
        ),
        //! -------------Appbar
        backgroundColor: Colors.grey[200],
        body: SafeArea(
            child: Container(
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => (cartContoller.itemsList.length == 0)
                    ? Expanded(
                        flex: 7,
                        child: Container(
                          color: whiteColor,
                          child: Center(
                            child: Text(
                              'No Item in Cart',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        flex: 7,
                        child: Container(
                          color: Colors.white,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: cartContoller.itemsList.length,
                              itemBuilder: (context, index) {
                                // var items = providerCart.basketItems[index];
                                var items = cartContoller.itemsList[index];
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                    width: 1.5,
                                    color: Colors.green.withOpacity(0.8),
                                  )),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.transparent,
                                        child: Image.network(items.imagePath),
                                      ),
                                      title: Text(
                                        //! For Capitalization
                                        '${items.name![0].toUpperCase()}${items.name!.substring(1)}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      subtitle: Wrap(
                                        children: [
                                          Text('Rs. ${items.price.toString()}' +
                                              " x " +
                                              items.quantity.toString() +
                                              " = "),
                                          Text(
                                            'Rs. ${items.quantity! * int.parse(items.price.toString())}',
                                            style: TextStyle(
                                                color: blackColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      trailing: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  cartContoller
                                                      .removeProduct(items);
                                                },
                                                child: Icon(
                                                  Icons.close,
                                                  size: 20.0,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 110,
                                                height: 34,
                                                child: CommonWidget()
                                                    .addToCartContainer(
                                                        items.quantity, () {},
                                                        () {
                                                  //! Increment
                                                  if (items.quantity ==
                                                      items.stock) {
                                                  } else {
                                                    cartContoller.updateProduct(
                                                        items,
                                                        items.quantity! + 1);
                                                  }
                                                }, () {
                                                  //! Decrement
                                                  cartContoller.updateProduct(
                                                      items,
                                                      items.quantity! - 1);
                                                }, () {
                                                  cartContoller
                                                      .removeProduct(items);
                                                }),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                );
                              }),
                        ),
                      ),
              ),
              //!------*****Total Data
              Expanded(
                flex: 3,
                child: Container(
                  color: greyColor!.withOpacity(0.05),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Obx(
                        () => SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                '(Free Delivery if Total more than Rs: ${cartContoller.freeDeliveryAfter.value})',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w300,
                                    color: blackColor),
                              ),
                              CommonWidget().sizedBox(10.0, 0.0),
                              totalRow(),
                              CommonWidget().sizedBox(10.0, 0.0),
                              CommonWidget().button(
                                  greenColor,
                                  whiteColor,
                                  (cartContoller.isUserLogin.value)
                                      ? 'Checkout'
                                      : 'Proceed to Checkout', () {
                                if (cartContoller.itemsList.isEmpty) {
                                  Get.dialog(StatusDialogue(
                                    contentString: 'No Item in Cart',
                                    stringColor: Colors.red,
                                  ));
                                } else if (cartContoller.totalprice.value <
                                    cartContoller.minAmountForOrder.value) {
                                  Get.dialog(StatusDialogue(
                                    contentString:
                                        'Min Order Amount is ${cartContoller.minAmountForOrder.value}',
                                    stringColor: Colors.red,
                                  ));
                                } else {
                                  print('checkout');
                                  (cartContoller.isUserLogin.value)
                                      ? Get.dialog(CheckOutScreen(),
                                          barrierDismissible: false)
                                      : Get.dialog(optionAlertDialogue());
                                }
                              }, EdgeInsets.all(10), 20.0, FontWeight.normal),
                            ],
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
        )));
  }

  Row totalRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => RichText(
            text: TextSpan(
              text: 'Total ',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
              children: [
                TextSpan(
                    text:
                        '(${cartContoller.itemsList.length.toString()} Items)',
                    style: TextStyle(
                        color: lightgreyColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Obx(() => Text(
                  'Rs. ${cartContoller.totalprice}',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
            Text(
              '(inc. of taxes)',
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ],
    );
  }

  Widget increButton(IconData iconData, function) {
    return Card(
      shape: StadiumBorder(),
      elevation: 4,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: IconButton(
          splashColor: Colors.transparent,
          icon: Icon(
            iconData,
            color: Colors.green,
          ),
          onPressed: function,
        ),
      ),
    );
  }
}
