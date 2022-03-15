import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Authentication/B2B_Login/b2b_login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaitingApproval extends StatelessWidget {
  final bool isWaitingApproval;
  const WaitingApproval({Key? key, required this.isWaitingApproval})
      : super(key: key);

  final String waitingText =
      'Thank you for registering with Taqwa Mart, Your application is being reviewed and will undergo an approval process.';
  final String forgottext = 'Forgot Your Password ?';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: isWaitingApproval ? false : true,
        title: Text(
          isWaitingApproval ? 'Waiting Approval' : 'Forgot Password',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.clear();
              Get.offAll(() => B2BLoginScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.power_settings_new),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
        child: Column(
          children: [
            CommonWidget().customText(
                isWaitingApproval ? waitingText : forgottext,
                blackColor,
                20.0,
                FontWeight.w400,
                5,
                alignment: TextAlign.center),
            CommonWidget().sizedBox(30.0, 0.0),
            Expanded(
                flex: 2,
                child: Image.asset(
                  'assets/Images/waiting_approval.png',
                  fit: BoxFit.cover,
                )),
            Expanded(
                child: Container(
              // color: Colors.red,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Center(
                child: CommonWidget()
                    .button(greenColor, whiteColor, 'CALL HELPLINE', () {
                                        makePhoneCall('tel:+923332918981');

                }, EdgeInsets.symmetric(vertical: 10.0), 20.0, FontWeight.w400),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
