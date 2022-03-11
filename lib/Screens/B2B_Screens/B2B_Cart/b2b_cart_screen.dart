import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Constant/Widgets/popUp.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Cart/b2b_cart_controller.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Checkout/b2b_checkout_screen.dart';

class B2BCartScreen extends StatelessWidget {
  B2BCartScreen({Key? key}) : super(key: key);

  final b2bCartContoller = Get.find<B2BCartController>();

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
                      '${b2bCartContoller.itemsList.length.toString()} Items',
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
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => (b2bCartContoller.itemsList.length == 0)
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
                            physics: ClampingScrollPhysics(),
                            itemCount: b2bCartContoller.itemsList.length,
                            itemBuilder: (context, index) {
                              // var items = providerCart.basketItems[index];
                              var items = b2bCartContoller.itemsList[index];
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

                                        // Text(
                                        // 'Rs. ${items.price.toString()}' +
                                        //     " x " +
                                        //     items.quantity.toString() +
                                        //     " = " +
                                        //     ('${items.quantity! * int.parse(items.price!)} Rs')
                                        //         .toString()),
                                      ],
                                    ),
                                    trailing: Container(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                b2bCartContoller
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
                                                  b2bCartContoller
                                                      .updateProduct(items,
                                                          items.quantity! + 1);
                                                }
                                              }, () {
                                                //! Decrement
                                                b2bCartContoller.updateProduct(
                                                    items, items.quantity! - 1);
                                              }, () {
                                                b2bCartContoller
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
                // color: whiteColor,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            '(Free Delivery if Total more than Rs:${b2bCartContoller.freeDeliveryAfter.value})',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300,
                                color: blackColor),
                          ),
                          CommonWidget().sizedBox(10.0, 0.0),
                          totalRow(),
                          CommonWidget().sizedBox(10.0, 0.0),
                          CommonWidget()
                              .button(greenColor, whiteColor, 'Check Out ', () {
                            if (b2bCartContoller.itemsList.length == 0) {
                              Get.dialog(StatusDialogue(
                                contentString: 'No Item in Cart',
                                stringColor: Colors.red,
                              ));
                              // Get.snackbar(
                              //   'Message',
                              //   'No Item in Cart',
                              //   snackPosition: SnackPosition.BOTTOM,
                              // );
                            } else if (b2bCartContoller.totalprice.value <
                                b2bCartContoller.minAmountForOrder.value) {
                              Get.dialog(StatusDialogue(
                                contentString:
                                    'Min Order Amount is ${b2bCartContoller.minAmountForOrder.value}',
                                stringColor: Colors.red,
                              ));
                            } else {
                              Get.dialog(B2BCheckOutScreen());
                            }
                          }, EdgeInsets.all(10), 20.0, FontWeight.normal),
                        ],
                      ),
                    )),
              ),
            ),
          ],
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
                        '(${b2bCartContoller.itemsList.length.toString()} Items)',
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
                  'Rs. ${b2bCartContoller.totalprice}',
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
