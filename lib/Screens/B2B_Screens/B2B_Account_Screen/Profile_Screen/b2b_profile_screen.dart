import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Account_Screen/Profile_Screen/b2b_profile_controller.dart';

class B2BProfileScreen extends StatelessWidget {
  final b2bProfileController = Get.put(B2bProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 100,
        backgroundColor: greenColor,
        title: CommonWidget().customText(
          'Profile',
          whiteColor,
          20.0,
          FontWeight.bold,
          1,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Profile',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.dialog(EditingAlertDialogue(
                        profileController: b2bProfileController,
                      )).then((value) => b2bProfileController
                          .phoneTextEditingController
                          .clear());
                    },
                    child: Wrap(
                      children: [
                        Text(
                          'Edit',
                          style: TextStyle(fontSize: 20.0, color: greenColor),
                        ),
                        CommonWidget().sizedBox(0.0, 5.0),
                        Icon(
                          Icons.edit,
                          color: greenColor,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Obx(() => (b2bProfileController.isLoading.value)
                  ? Center(
                      child: CircularProgressIndicator(
                        color: greenColor,
                      ),
                    )
                  : Column(
                      children: [
                        //!-------****Detail
                        detailListtile(Icons.person, 'Full Name',
                            b2bProfileController.fullName.value),
                        detailListtile(Icons.store, 'Shop Name',
                            b2bProfileController.shopName.value),
                        detailListtile(Icons.phone, 'Mobile no',
                            b2bProfileController.mobileNo.value),
                        detailListtile(Icons.location_on, 'Address',
                            b2bProfileController.address.value),
                      ],
                    ))
            ],
          ),
        ),
      ),
    );
  }

  Widget detailListtile(icon, title, subtitle) {
    return ListTile(
      horizontalTitleGap: 0,
      leading: Icon(
        icon,
        color: greenColor,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 18.0, color: Colors.grey),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 20.0, color: Colors.black),
      ),
    );
  }
}
