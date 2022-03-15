import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';

class ReferScreen extends StatelessWidget {
  const ReferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 80,
        backgroundColor: greenColor,
        title: Text('Invite a friend'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        )),
      ),
      // AppBar(
      //   title: Text(
      //     'Invite a friend ',
      //     style: Theme.of(context).appBarTheme.titleTextStyle,
      //   ),
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.arrow_back,
      //       color: Colors.black,
      //     ),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                  child: Image.asset(
                    'assets/Images/referFriend1.png',
                    height: 150,
                  ),
                )),
                Expanded(
                    child: Container(
                  child: Image.asset(
                    'assets/Images/referFriend2.png',
                    height: 150,
                  ),
                )),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  rowData('assets/Images/Icon_wallet.png',
                      'Earn Credits worth Rs 200 when your referral completes their first order'),
                  CommonWidget().sizedBox(20.0, 0.0),
                  rowData('assets/Images/Icon_coins.png',
                      'Everytime your friends place an order, you win reward points aquivalent to 20% of the reward points they earn'),
                  CommonWidget().sizedBox(30.0, 0.0),
                  DottedBorder(
                    color: Colors.red,
                    strokeWidth: 1,
                    dashPattern: [6, 6, 6, 6],
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'SHAHZASUI908',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  CommonWidget().sizedBox(10.0, 0.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: CommonWidget().button(
                        greenColor,
                        whiteColor,
                        'Share Referral Code',
                        () {},
                        EdgeInsets.zero,
                        20.0,
                        FontWeight.w500),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowData(iconImage, text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          iconImage,
          height: 30,
        ),
        SizedBox(
          width: 30,
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }
}
// Earn Mungalo Credits worth Rs 200 when your referral completes their first order